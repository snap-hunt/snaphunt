import 'package:flutter/material.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/ui/login.dart';
import 'package:snaphunt/ui/multiplayer/lobby.dart';
import 'package:snaphunt/ui/singleplayer/singleplayer.dart';

class Router {
  static const String home = '/';
  static const String login = '/login';
  static const String lobby = '/multiplayer';
  static const String singlePlayer = '/singleplayer';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Home());

      case lobby:
        return MaterialPageRoute(builder: (_) => Lobby());

      case singlePlayer:
        return MaterialPageRoute(builder: (_) => SinglePlayer());

      case login:
      default:
        return MaterialPageRoute(builder: (_) => Login());
    }
  }
}
