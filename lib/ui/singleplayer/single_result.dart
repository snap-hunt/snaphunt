import 'package:flutter/material.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

class ResultScreenSinglePlayer extends StatelessWidget {
  final bool isHuntFinished;
  final List<Hunt> objects;
  final Duration duration;

  const ResultScreenSinglePlayer(
      {Key key, this.isHuntFinished, this.objects, this.duration})
      : super(key: key);

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    final found = objects.where((hunt) => hunt.isFound).length;
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const UserInfo(),
          SizedBox(height: 30),
          Text(
            isHuntFinished ? 'Congrats!' : 'Better luck next time!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            '$found/${objects.length} found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            'in ${formatHHMMSS(duration.inSeconds)}!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 30),
          FancyButton(
            child: Text(
              "Back",
              style: TextStyle(color: Colors.white),
            ),
            size: 50,
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )),
    );
  }
}
