import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/stores/hunt_model.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/common/hunt_game.dart';

class SinglePlayer extends StatelessWidget {
  final int numOfObjects;
  final int duration;

  const SinglePlayer({Key key, this.numOfObjects, this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HuntModel(
        objects: generateHuntObjects(numOfObjects),
        timeLimit: DateTime.now().add(Duration(minutes: duration)),
      ),
      child: const HuntGame(
        title: 'SinglePlayer!',
      ),
    );
  }
}
