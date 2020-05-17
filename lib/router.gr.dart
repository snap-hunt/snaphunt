// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/ui/login.dart';
import 'package:snaphunt/ui/multiplayer/lobby.dart';
import 'package:snaphunt/ui/multiplayer/create_room.dart';
import 'package:snaphunt/ui/multiplayer/multiplayer.dart';
import 'package:snaphunt/model/player.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/ui/multiplayer/room.dart';
import 'package:snaphunt/ui/multiplayer/multiplayer_result.dart';
import 'package:snaphunt/ui/singleplayer/single_settings.dart';
import 'package:snaphunt/ui/singleplayer/singleplayer.dart';
import 'package:snaphunt/ui/singleplayer/single_result.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/ui/how_to_play.dart';

abstract class Routes {
  static const home = '/home';
  static const login = '/';
  static const lobby = '/lobby';
  static const createRoom = '/create-room';
  static const multiPlayer = '/multi-player';
  static const room = '/room';
  static const resultMultiPlayer = '/result-multi-player';
  static const singlePlayerSettings = '/single-player-settings';
  static const singlePlayer = '/single-player';
  static const resultScreenSinglePlayer = '/result-screen-single-player';
  static const howToPlay = '/how-to-play';
  static const all = {
    home,
    login,
    lobby,
    createRoom,
    multiPlayer,
    room,
    resultMultiPlayer,
    singlePlayerSettings,
    singlePlayer,
    resultScreenSinglePlayer,
    howToPlay,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        if (hasInvalidArgs<HomeArguments>(args)) {
          return misTypedArgsRoute<HomeArguments>(args);
        }
        final typedArgs = args as HomeArguments ?? HomeArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => Home(key: typedArgs.key),
          settings: settings,
        );
      case Routes.login:
        if (hasInvalidArgs<LoginArguments>(args)) {
          return misTypedArgsRoute<LoginArguments>(args);
        }
        final typedArgs = args as LoginArguments ?? LoginArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => Login(key: typedArgs.key),
          settings: settings,
        );
      case Routes.lobby:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Lobby(),
          settings: settings,
        );
      case Routes.createRoom:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreateRoom(),
          settings: settings,
        );
      case Routes.multiPlayer:
        if (hasInvalidArgs<MultiPlayerArguments>(args)) {
          return misTypedArgsRoute<MultiPlayerArguments>(args);
        }
        final typedArgs =
            args as MultiPlayerArguments ?? MultiPlayerArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => MultiPlayer(
              key: typedArgs.key,
              userId: typedArgs.userId,
              players: typedArgs.players,
              game: typedArgs.game),
          settings: settings,
        );
      case Routes.room:
        if (hasInvalidArgs<RoomArguments>(args)) {
          return misTypedArgsRoute<RoomArguments>(args);
        }
        final typedArgs = args as RoomArguments ?? RoomArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => Room(
                  key: typedArgs.key,
                  game: typedArgs.game,
                  userId: typedArgs.userId,
                  isHost: typedArgs.isHost)
              .wrappedRoute(context),
          settings: settings,
        );
      case Routes.resultMultiPlayer:
        if (hasInvalidArgs<ResultMultiPlayerArguments>(args)) {
          return misTypedArgsRoute<ResultMultiPlayerArguments>(args);
        }
        final typedArgs =
            args as ResultMultiPlayerArguments ?? ResultMultiPlayerArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => ResultMultiPlayer(
              key: typedArgs.key,
              gameId: typedArgs.gameId,
              title: typedArgs.title,
              duration: typedArgs.duration),
          settings: settings,
        );
      case Routes.singlePlayerSettings:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SinglePlayerSettings(),
          settings: settings,
        );
      case Routes.singlePlayer:
        if (hasInvalidArgs<SinglePlayerArguments>(args)) {
          return misTypedArgsRoute<SinglePlayerArguments>(args);
        }
        final typedArgs =
            args as SinglePlayerArguments ?? SinglePlayerArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SinglePlayer(
              key: typedArgs.key,
              numOfObjects: typedArgs.numOfObjects,
              duration: typedArgs.duration),
          settings: settings,
        );
      case Routes.resultScreenSinglePlayer:
        if (hasInvalidArgs<ResultScreenSinglePlayerArguments>(args)) {
          return misTypedArgsRoute<ResultScreenSinglePlayerArguments>(args);
        }
        final typedArgs = args as ResultScreenSinglePlayerArguments ??
            ResultScreenSinglePlayerArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => ResultScreenSinglePlayer(
              key: typedArgs.key,
              isHuntFinished: typedArgs.isHuntFinished,
              objects: typedArgs.objects,
              duration: typedArgs.duration),
          settings: settings,
        );
      case Routes.howToPlay:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HowToPlay(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//Home arguments holder class
class HomeArguments {
  final Key key;
  HomeArguments({this.key});
}

//Login arguments holder class
class LoginArguments {
  final Key key;
  LoginArguments({this.key});
}

//MultiPlayer arguments holder class
class MultiPlayerArguments {
  final Key key;
  final String userId;
  final List<Player> players;
  final Game game;
  MultiPlayerArguments({this.key, this.userId, this.players, this.game});
}

//Room arguments holder class
class RoomArguments {
  final Key key;
  final Game game;
  final String userId;
  final bool isHost;
  RoomArguments({this.key, this.game, this.userId, this.isHost});
}

//ResultMultiPlayer arguments holder class
class ResultMultiPlayerArguments {
  final Key key;
  final String gameId;
  final String title;
  final int duration;
  ResultMultiPlayerArguments(
      {this.key, this.gameId, this.title, this.duration});
}

//SinglePlayer arguments holder class
class SinglePlayerArguments {
  final Key key;
  final int numOfObjects;
  final int duration;
  SinglePlayerArguments({this.key, this.numOfObjects, this.duration});
}

//ResultScreenSinglePlayer arguments holder class
class ResultScreenSinglePlayerArguments {
  final Key key;
  final bool isHuntFinished;
  final List<Hunt> objects;
  final Duration duration;
  ResultScreenSinglePlayerArguments(
      {this.key, this.isHuntFinished, this.objects, this.duration});
}

// *************************************************************************
// Navigation helper methods extension
// **************************************************************************

extension RouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushHome({
    Key key,
  }) =>
      pushNamed(
        Routes.home,
        arguments: HomeArguments(key: key),
      );

  Future pushLogin({
    Key key,
  }) =>
      pushNamed(
        Routes.login,
        arguments: LoginArguments(key: key),
      );

  Future pushLobby() => pushNamed(Routes.lobby);

  Future pushCreateRoom() => pushNamed(Routes.createRoom);

  Future pushMultiPlayer({
    Key key,
    String userId,
    List<Player> players,
    Game game,
  }) =>
      pushNamed(
        Routes.multiPlayer,
        arguments: MultiPlayerArguments(
            key: key, userId: userId, players: players, game: game),
      );

  Future pushRoom({
    Key key,
    Game game,
    String userId,
    bool isHost,
  }) =>
      pushNamed(
        Routes.room,
        arguments:
            RoomArguments(key: key, game: game, userId: userId, isHost: isHost),
      );

  Future pushResultMultiPlayer({
    Key key,
    String gameId,
    String title,
    int duration,
  }) =>
      pushNamed(
        Routes.resultMultiPlayer,
        arguments: ResultMultiPlayerArguments(
            key: key, gameId: gameId, title: title, duration: duration),
      );

  Future pushSinglePlayerSettings() => pushNamed(Routes.singlePlayerSettings);

  Future pushSinglePlayer({
    Key key,
    int numOfObjects,
    int duration,
  }) =>
      pushNamed(
        Routes.singlePlayer,
        arguments: SinglePlayerArguments(
            key: key, numOfObjects: numOfObjects, duration: duration),
      );

  Future pushResultScreenSinglePlayer({
    Key key,
    bool isHuntFinished,
    List<Hunt> objects,
    Duration duration,
  }) =>
      pushNamed(
        Routes.resultScreenSinglePlayer,
        arguments: ResultScreenSinglePlayerArguments(
            key: key,
            isHuntFinished: isHuntFinished,
            objects: objects,
            duration: duration),
      );

  Future pushHowToPlay() => pushNamed(Routes.howToPlay);
}
