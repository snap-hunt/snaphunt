import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snaphunt/constants/game_status_enum.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/game.dart';

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
    initGameStatusListener();
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  void initGameStatusListener() {
    gameStream =
        repository.gameSnapshot(_game.id).listen((DocumentSnapshot snapshot) {
      final status = snapshot.data['status'];
      if (status == 'cancelled') {
        // _isCancelled = true;
        _status = GameStatus.cancelled;
        notifyListeners();
      } else if (status == 'game') {
        // _isGameStart = true;
        _status = GameStatus.game;
        notifyListeners();
      }
    });
  }

  void onDispose() {
    if (_isHost) {
      repository.cancelRoom(_game.id);
    } else {
      repository.leaveRoom(_game.id, _userId);
    }

    gameStream.cancel();
  }

  Future joinRoom() async {
    return repository.joinRoom(_game.id, _userId);
  }
}
