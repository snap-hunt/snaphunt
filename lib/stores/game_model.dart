import 'package:flutter/material.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/game.dart';

class GameModel extends ChangeNotifier {
  Game _game;
  Game get game => _game;

  bool _isHost = false;
  bool get isHost => _isHost;

  final repository = Repository.instance;

  GameModel(this._game, this._isHost);

  void updateGame(Game game) {
    _game = game;
  }
}
