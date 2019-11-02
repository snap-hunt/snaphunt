import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/stores/game_model.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/ui/login.dart';
import 'package:snaphunt/ui/multiplayer/create_room.dart';
import 'package:snaphunt/ui/multiplayer/lobby.dart';
import 'package:snaphunt/ui/multiplayer/multiplayer.dart';
import 'package:snaphunt/ui/multiplayer/room.dart';
import 'package:snaphunt/ui/singleplayer/single_result.dart';
import 'package:snaphunt/ui/singleplayer/single_settings.dart';
import 'package:snaphunt/ui/singleplayer/singleplayer.dart';

class Router {
  static const String home = '/';

  static const String login = '/login';

  static const String lobby = '/multiplayer';
  static const String create = '/createRoom';
  static const String room = '/room';
  static const String game = '/game';

  static const String singlePlayerSettings = '/singleplayerSettings';
  static const String singlePlayer = '/singleplayer';
  static const String resultSingle = '/singleplayerResult';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Home());

      case lobby:
        return MaterialPageRoute(builder: (_) => Lobby());

      case create:
        return MaterialPageRoute(builder: (_) => CreateRoom());

      case game:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => MultiPlayer(
            roomTitle: args[0],
            huntOjects: args[1],
            timeLimit: args[2],
            gameId: args[3],
            userId: args[4],
          ),
        );

      case room:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            builder: (_) => GameModel(
              args[0],
              args[1],
              args[2],
            ),
            child: Room(),
          ),
        );
      case singlePlayerSettings:
        return MaterialPageRoute(builder: (_) => SinglePlayerSettings());

      case singlePlayer:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => SinglePlayer(
            numOfObjects: args[0],
            duration: args[1],
          ),
        );

      case resultSingle:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => ResultScreenSinglePlayer(
            isHuntFinished: args[0],
            objects: args[1],
            duration: args[2],
          ),
        );

      case login:
      default:
        return MaterialPageRoute(builder: (_) => Login());
    }
  }
}
