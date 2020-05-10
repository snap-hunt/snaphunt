import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/model/player.dart';
import 'package:snaphunt/stores/game_model.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/ui/login.dart';
import 'package:snaphunt/ui/how_to_play.dart';
import 'package:snaphunt/ui/multiplayer/create_room.dart';
import 'package:snaphunt/ui/multiplayer/lobby.dart';
import 'package:snaphunt/ui/multiplayer/multiplayer.dart';
import 'package:snaphunt/ui/multiplayer/multiplayer_result.dart';
import 'package:snaphunt/ui/multiplayer/room.dart';
import 'package:snaphunt/ui/singleplayer/single_result.dart';
import 'package:snaphunt/ui/singleplayer/single_settings.dart';
import 'package:snaphunt/ui/singleplayer/singleplayer.dart';

class Router {
  static const String home = '/';

  static const String login = '/login';
  static const String howToPlay = '/howToPlay';

  static const String lobby = '/multiplayer';
  static const String create = '/createRoom';
  static const String room = '/room';
  static const String game = '/game';
  static const String resultMulti = '/multiplayerResult';

  static const String singlePlayerSettings = '/singleplayerSettings';
  static const String singlePlayer = '/singleplayer';
  static const String resultSingle = '/singleplayerResult';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const Home());

      case lobby:
        return MaterialPageRoute(builder: (_) => Lobby());

      case create:
        return MaterialPageRoute(builder: (_) => CreateRoom());

      case game:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => MultiPlayer(
            game: args[0] as Game,
            userId: args[1] as String,
            players: args[2] as List<Player>,
          ),
        );

      case room:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            builder: (_) => GameModel(
              args[0] as Game,
              args[2] as String,
              isHost: args[1] as bool,
            ),
            child: Room(),
          ),
        );

      case resultMulti:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => ResultMultiPlayer(
            gameId: args[0] as String,
            title: args[1] as String,
            duration: args[2] as int,
          ),
        );

      case singlePlayerSettings:
        return MaterialPageRoute(builder: (_) => SinglePlayerSettings());

      case singlePlayer:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => SinglePlayer(
            numOfObjects: args[0] as int,
            duration: args[1] as int,
          ),
        );

      case resultSingle:
        final args = settings.arguments as List;

        return MaterialPageRoute(
          builder: (_) => ResultScreenSinglePlayer(
            isHuntFinished: args[0] as bool,
            objects: args[1] as List<Hunt>,
            duration: args[2] as Duration,
          ),
        );

      case howToPlay:
        return MaterialPageRoute(builder: (_) => HowToPlay());

      case login:
      default:
        return MaterialPageRoute(builder: (_) => const Login());
    }
  }
}
