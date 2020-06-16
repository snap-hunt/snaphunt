import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';
import 'package:snaphunt/widgets/common/wave.dart';

import '../../router.gr.dart';

class ResultScreenSinglePlayer extends StatelessWidget {
  final bool isHuntFinished;
  final List<Hunt> objects;
  final Duration duration;

  const ResultScreenSinglePlayer(
      {Key key, this.isHuntFinished, this.objects, this.duration})
      : super(key: key);

  String formatHHMMSS(int seconds) {
    final int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final int minutes = (seconds / 60).truncate();

    final String hoursStr = (hours).toString().padLeft(2, '0');
    final String minutesStr = (minutes).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

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
          color: Colors.white,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('assets/top.png', scale: 1),
              // Image.asset('assets/main.png', height: 185),

              const SizedBox(height: 15),
              const UserInfo(),
              const SizedBox(height: 20),
              Text(
                isHuntFinished
                    ? 'Congrats! You found all items'
                    : 'Better luck next time!',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 25),
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
              const SizedBox(height: 20),
              FancyButton(
                size: 70,
                color: Colors.blue,
                onPressed: () {
                  ExtendedNavigator.of(context)
                      .popUntil(ModalRoute.withName(Routes.home));
                },
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              CustomWaveWidget()
            ],
          )),
    );
  }
}
