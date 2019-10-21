import 'package:flutter/material.dart';
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

  bool _canStartGame = false;
  bool get canStartGame => _canStartGame;

  bool _isGameStart = false;
  bool get isGameStart => _isGameStart;

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
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  void onDispose() {}

  Future joinRoom() async {
    return repository.joinRoom(_game.id, _userId);
  }
}
