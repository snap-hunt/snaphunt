import 'package:flutter/material.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/widgets/fancy_button.dart';

class LobbyButtons extends StatelessWidget {
  final Function onJoinRoom;
  final Function onCreateRoom;

  const LobbyButtons({Key key, this.onJoinRoom, this.onCreateRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Snap Rooms',
            style: TextStyle(fontSize: 24),
          ),
          FancyButton(
            child: Text(
              'Join Room',
              style: fancy_button_style,
            ),
            color: Colors.orange,
            size: 40,
            onPressed: onJoinRoom,
          ),
          FancyButton(
            child: Text(
              'Create Room',
              style: fancy_button_style,
            ),
            color: Colors.red,
            size: 40,
            onPressed: onCreateRoom,
          ),
        ],
      ),
    );
  }
}
