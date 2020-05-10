import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/model/player.dart';
import 'package:snaphunt/stores/hunt_model.dart';
import 'package:snaphunt/widgets/common/hunt_game.dart';
import 'package:snaphunt/utils/utils.dart';

class MultiPlayer extends StatelessWidget {
  final Game game;
  final String userId;
  final List<Player> players;

  const MultiPlayer({
    Key key,
    this.userId,
    this.players,
    this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HuntModel(
        objects: generateHuntObjectsFromList(game.words),
        timeLimit: game.gameStartTime.add(Duration(minutes: game.timeLimit)),
        isMultiplayer: true,
        gameId: game.id,
        userId: userId,
        timeDuration: game.timeLimit,
      ),
      child: HuntGame(
        title: game.name,
        players: players,
      ),
    );
  }
}
