import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/stores/hunt_model.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/common/camera.dart';
import 'package:snaphunt/widgets/common/countdown.dart';
import 'package:snaphunt/widgets/multiplayer/room_exit_dialog.dart';

class SinglePlayer extends StatelessWidget {
  final test = [
    Hunt(word: 'chair'),
    // Hunt(word: 'sky'),
    // Hunt(word: 'table'),
    Hunt(word: 'room'),
    // Hunt(word: 'bag'),
    // Hunt(word: 'mobile phone'),
    // Hunt(word: 'food'),
    // Hunt(word: 'dog'),
    // Hunt(word: 'cat'),
    // Hunt(word: 'musicial instrument'),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => new HuntModel(
        objects: test,
        timeLimit: DateTime.now().add(Duration(minutes: 3)),
      ),
      child: HuntGame(),
    );
  }
}

class HuntGame extends StatelessWidget {
  void statusListener(HuntModel model, BuildContext context) {
    if (model.isTimeUp) {
      Navigator.of(context).pushReplacementNamed(Router.resultSingle);
      showAlertDialog(
        context: context,
        title: 'Times up!',
        body: 'Times up! Hunting stops now!',
      );
    } else if (model.isHuntComplete) {
      Navigator.of(context).pushReplacementNamed(Router.resultSingle);
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
            'SnapHunt!',
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
            return child;
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  child: CameraScreen(),
                ),
                WordList()
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
    return Consumer<HuntModel>(
      builder: (context, model, child) {
        return Container(
          height: 200,
          child: Wrap(
            direction: Axis.vertical,
            children: <Widget>[
              for (Hunt word in model.objects)
                WordTile(
                  word: word,
                ),
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
      children: <Widget>[
        Icon(Icons.check_circle),
        Text(
          word.word,
          style: TextStyle(
            decoration: word.isFound ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }
}
