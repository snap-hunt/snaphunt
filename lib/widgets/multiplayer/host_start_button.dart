import 'package:flutter/material.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

class HostStartButton extends StatelessWidget {
  final bool canStartGame;
  final Function onGameStart;

  const HostStartButton({
    Key key,
    this.canStartGame,
    this.onGameStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FancyButton(
            child: Text(
              'BEGIN HUNT',
              style: fancy_button_style,
            ),
            color: canStartGame ? Colors.deepOrangeAccent : Colors.grey,
            size: 70,
            onPressed: canStartGame ? onGameStart : null,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
