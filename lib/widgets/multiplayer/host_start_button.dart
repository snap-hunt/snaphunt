import 'package:flutter/material.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

class HostStartButton extends StatelessWidget {
  final bool canStartGame;
  final VoidCallback onGameStart;

  const HostStartButton({
    Key key,
    this.canStartGame,
    this.onGameStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FancyButton(
          color: canStartGame ? Colors.deepOrangeAccent : Colors.grey,
          size: 70,
          onPressed: canStartGame ? onGameStart : null,
          child: Text(
            'BEGIN HUNT',
            style: fancyButtonStyle,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
