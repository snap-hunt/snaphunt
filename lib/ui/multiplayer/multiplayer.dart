import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/stores/hunt_model.dart';
import 'package:snaphunt/widgets/common/hunt_game.dart';

class MultiPlayer extends StatelessWidget {
  final String roomTitle;
  final List<Hunt> huntOjects;
  final DateTime timeLimit;
  final String gameId;

  const MultiPlayer({
    Key key,
    this.roomTitle,
    this.huntOjects,
    this.gameId,
    this.timeLimit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => new HuntModel(
        objects: huntOjects,
        timeLimit: timeLimit,
        isMultiplayer: true,
        gameId: gameId,
      ),
      child: HuntGame(
        title: roomTitle,
      ),
    );
  }
}
