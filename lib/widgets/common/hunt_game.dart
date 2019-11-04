import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/model/player.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/stores/hunt_model.dart';
import 'package:snaphunt/stores/player_hunt_model.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/common/camera.dart';
import 'package:snaphunt/widgets/common/countdown.dart';
import 'package:snaphunt/widgets/multiplayer/room_exit_dialog.dart';

class HuntGame extends StatelessWidget {
  final String title;
  final List<Player> players;

  const HuntGame({Key key, this.title, this.players}) : super(key: key);

  void statusListener(HuntModel model, BuildContext context) {
    if (model.isTimeUp) {
      Navigator.of(context).pushReplacementNamed(
        Router.resultSingle,
        arguments: [
          model.isHuntComplete,
          model.objects,
          model.duration.elapsed,
        ],
      );
      showAlertDialog(
        context: context,
        title: 'Times up!',
        body: 'Times up! Hunting stops now!',
      );
    } else if (model.isHuntComplete) {
      Navigator.of(context).pushReplacementNamed(
        Router.resultSingle,
        arguments: [
          model.isHuntComplete,
          model.objects,
          model.duration.elapsed,
        ],
      );
      showAlertDialog(
        context: context,
        title: 'Congrats!',
        body: 'All items found! You are a champion!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final roomCode = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return RoomExitDialog(
              title: 'Leave game?',
              body:
                  'Are you sure you want to leave the game? Your progress will be lost',
            );
          },
        );

        return roomCode;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          actions: <Widget>[
            Consumer<HuntModel>(
              builder: (widget, model, child) {
                return CountDownTimer(timeLimit: model.timeLimit);
              },
            )
          ],
        ),
        body: Consumer<HuntModel>(
          builder: (context, model, child) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => statusListener(model, context),
            );

            if (model.isMultiplayer) {
              return Stack(
                children: <Widget>[
                  child,
                  PlayerUpdate(
                    gameId: model.gameId,
                    players: players,
                  ),
                ],
              );
            }
            return child;
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                WordList(),
                Expanded(child: CameraScreen()),
              ],
            ),
          ),
        ),
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
          color: Colors.grey[800],
          constraints: BoxConstraints(maxHeight: size.height * 0.2),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
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
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            word.isFound ? Icons.check : Icons.fiber_manual_record,
            color: word.isFound ? Colors.green : Colors.red,
          ),
          SizedBox(width: 10),
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
      ),
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
      builder: (_) => PlayHuntModel(
        gameId: gameId,
        players: players,
      ),
      child: Consumer<PlayHuntModel>(
        builder: (context, model, child) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: model.players.length,
              itemBuilder: (context, index) {
                final player = model.players[index];

                return Stack(
                  children: <Widget>[],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
