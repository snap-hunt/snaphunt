import 'package:flutter/material.dart';

class PlayerAwaitButton extends StatelessWidget {
  final bool canStartGame;

  const PlayerAwaitButton({
    Key key,
    this.canStartGame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const CircularProgressIndicator(),
        const SizedBox(height: 14),
        Text(canStartGame ? 'Waiting for host' : 'Waiting for player')
      ],
    );
  }
}
