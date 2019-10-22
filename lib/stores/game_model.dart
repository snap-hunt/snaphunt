import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snaphunt/constants/game_status_enum.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/model/player.dart';

class GameModel extends ChangeNotifier {
  Game _game;
  Game get game => _game;

  bool _isHost;
  bool get isHost => _isHost;

  String _userId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  GameStatus _status = GameStatus.waiting;
  GameStatus get status => _status;

  bool _isCancelled = false;
  bool get isCancelled => _isCancelled;

  bool _isKicked = false;
  bool get isKicked => _isKicked;

  bool _isGameStart = false;
  bool get isGameStart => _isGameStart;

  bool _canStartGame = false;
  bool get canStartGame => _canStartGame;

  StreamSubscription<DocumentSnapshot> gameStream;
  StreamSubscription<QuerySnapshot> playerStream;

  List<Player> _players = [];
  List<Player> get players => _players;

  final repository = Repository.instance;

  GameModel(this._game, this._isHost, this._userId);

  @override
  void addListener(listener) {
    initRoom();
    super.addListener(listener);
  }

  void initRoom() async {
    _isLoading = true;
    notifyListeners();

    if (_isHost) {
      String id = await repository.createRoom(_game);
      _game.id = id;
    }

    await joinRoom();

    _isLoading = false;
    notifyListeners();

    initStreams();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  void initStreams() {
    gameStream = repository.gameSnapshot(_game.id).listen(gameStatusListener);
    playerStream = repository.playersSnapshot(_game.id).listen(playerListener);
  }

  void gameStatusListener(DocumentSnapshot snapshot) {
    final status = snapshot.data['status'];
    if (status == 'cancelled') {
      _status = GameStatus.cancelled;
      notifyListeners();
    } else if (status == 'game') {
      _status = GameStatus.game;
      notifyListeners();
    }
  }

  void playerListener(QuerySnapshot snapshot) {
    snapshot.documentChanges.forEach((DocumentChange change) async {
      print(change.type);
      print(change.document.documentID);

      if (DocumentChangeType.added == change.type) {
        players.add(
            Player(user: await repository.getUser(change.document.documentID)));
      }

      notifyListeners();
    });
  }

  void onDispose() {
    if (_isHost) {
      repository.cancelRoom(_game.id);
    } else {
      repository.leaveRoom(_game.id, _userId);
    }

    gameStream.cancel();
    playerStream.cancel();
  }

  Future joinRoom() async {
    final playerCount = await repository.getGamePlayerCount(_game.id);

    if (playerCount >= _game.maxPlayers) {
      _status = GameStatus.full;
      return Future.value(null);
    }

    return repository.joinRoom(_game.id, _userId);
  }
}
