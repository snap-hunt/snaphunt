import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/model/player.dart';
import 'package:snaphunt/router.gr.dart';
import 'package:snaphunt/stores/hunt_model.dart';
import 'package:snaphunt/stores/player_hunt_model.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/common/camera.dart';
import 'package:snaphunt/widgets/common/countdown.dart';
import 'package:snaphunt/widgets/multiplayer/room_exit_dialog.dart';

class HuntGame extends StatelessWidget {
  final String title;
  final List<Player> players;

  const HuntGame({Key key, this.title, this.players}) : super(key: key);

  void statusListener(HuntModel model, BuildContext context) {
    if (model.isMultiplayer) {
      if (model.isTimeUp) {
        pushMultiPlayerResult(
          model,
          context,
          title: 'Times up!',
          body: 'Times up! Hunting stops now!',
          gameTitle: title,
          duration: model.timeDuration,
        );
      } else if (model.isGameEnd && model.isHuntComplete) {
        pushMultiPlayerResult(
          model,
          context,
          title: 'Congrats!',
          body: 'All items found! You are a champion!',
          gameTitle: title,
          duration: model.timeDuration,
        );
      } else if (model.isGameEnd && !model.isHuntComplete) {
        pushMultiPlayerResult(
          model,
          context,
          title: 'Hunt Ended!',
          body: 'Someone completed the hunt!',
          gameTitle: title,
          duration: model.timeDuration,
        );
      }
    } else {
      if (model.isTimeUp) {
        pushSinglePlayerResult(
          model,
          context,
          title: 'Times up!',
          body: 'Times up! Hunting stops now!',
        );
      } else if (model.isHuntComplete) {
        pushSinglePlayerResult(
          model,
          context,
          title: 'Congrats!',
          body: 'All items found! You are a champion!',
        );
      }
    }
  }

  void pushSinglePlayerResult(
    HuntModel model,
    BuildContext context, {
    String title,
    String body,
  }) {
    ExtendedNavigator.rootNavigator.pushReplacementNamed(
      Routes.resultScreenSinglePlayer,
      arguments: ResultScreenSinglePlayerArguments(
        isHuntFinished: model.isHuntComplete,
        duration: model.duration.elapsed,
        objects: model.objects,
      ),
    );

    showAlertDialog(
      context: context,
      title: title,
      body: body,
    );
  }

  void pushMultiPlayerResult(
    HuntModel model,
    BuildContext context, {
    String title,
    String body,
    String gameTitle,
    int duration,
  }) {
    ExtendedNavigator.rootNavigator.pushReplacementNamed(
      Routes.resultMultiPlayer,
      arguments: ResultMultiPlayerArguments(
        duration: duration,
        gameId: model.gameId,
        title: gameTitle,
      ),
    );

    showAlertDialog(
      context: context,
      title: title,
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final roomCode = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const RoomExitDialog(
              title: 'Leave game?',
              body:
                  'Are you sure you want to leave the game? Your progress will be lost',
            );
          },
        );

        return roomCode;
      },
      child: Scaffold(
        body: Consumer<HuntModel>(
          builder: (context, model, child) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => statusListener(model, context),
            );

            return Stack(
              children: <Widget>[
                child,
                HeaderRow(
                  title: title,
                  timeLimit: model.timeLimit,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 90),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (model.isMultiplayer)
                        PlayerUpdate(
                          gameId: model.gameId,
                          players: players,
                        ),
                      ExpandedWordList(
                        objectsFound: model.objectsFound,
                        totalObjects: model.objects.length,
                        hunt: model.nextNotFound,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          child: const CameraScreen(),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  final String title;
  final DateTime timeLimit;

  const HeaderRow({Key key, this.title, this.timeLimit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8.0,
        left: 24.0,
        right: 24.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          CountDownTimer(timeLimit: timeLimit)
        ],
      ),
    );
  }
}

class ExpandedWordList extends StatelessWidget {
  final int objectsFound;

  final int totalObjects;

  final Hunt hunt;

  const ExpandedWordList({
    Key key,
    this.objectsFound,
    this.totalObjects,
    this.hunt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Items ($objectsFound/$totalObjects)',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            if (hunt != null) WordTile(word: hunt)
          ],
        ),
      ),
      expanded: WordList(),
      theme: const ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        tapBodyToCollapse: true,
        tapHeaderToExpand: true,
        hasIcon: true,
        iconColor: Colors.white,
      ),
    );
  }
}

class WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<HuntModel>(
      builder: (context, model, child) {
        return Container(
          width: double.infinity,
          color: Colors.transparent,
          constraints: BoxConstraints(maxHeight: size.height * 0.4),
          padding: const EdgeInsets.only(left: 16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 14,
                direction: Axis.horizontal,
                children: <Widget>[
                  for (Hunt word in model.objects)
                    WordTile(
                      word: word,
                    ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class WordTile extends StatelessWidget {
  final Hunt word;

  const WordTile({Key key, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          word.isFound ? Icons.check : Icons.fiber_manual_record,
          color: word.isFound ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 10),
        AutoSizeText(
          word.word,
          maxLines: 1,
          minFontSize: 10,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            decoration: word.isFound ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }
}

class PlayerUpdate extends StatelessWidget {
  final String gameId;

  final List<Player> players;

  const PlayerUpdate({Key key, this.gameId, this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayHuntModel(
        gameId: gameId,
        players: players,
      ),
      child: Consumer<PlayHuntModel>(
        builder: (context, model, child) {
          return Container(
            margin: const EdgeInsets.all(8),
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: model.players.length,
              itemBuilder: (context, index) {
                final player = model.players[index];
                return ScoreAvatar(
                  photoUrl: player.user.photoUrl,
                  score: player.score,
                  userBorderColor: user_colors[index % 4],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ScoreAvatar extends StatelessWidget {
  final String photoUrl;
  final int score;
  final Color userBorderColor;

  const ScoreAvatar({Key key, this.photoUrl, this.score, this.userBorderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          UserAvatar(
            borderColor: userBorderColor,
            photoUrl: photoUrl,
            height: 50,
          ),
          const SizedBox(width: 10),
          Text(
            '$score',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarScore extends StatelessWidget {
  final int score;

  const AvatarScore({Key key, this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      child: Text('$score'),
    );
  }
}
