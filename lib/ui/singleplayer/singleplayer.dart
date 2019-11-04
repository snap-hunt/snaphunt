import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/stores/hunt_model.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/common/hunt_game.dart';

class SinglePlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => new HuntModel(
        objects: generateHuntObjects(5),
        timeLimit: DateTime.now().add(Duration(minutes: 3)),
      ),
      child: HuntGame(
        title: 'SinglePlayer!',
      ),
    );
  }
}
