import 'package:flutter/material.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

class LobbyButtons extends StatelessWidget {
  final VoidCallback onJoinRoom;
  final VoidCallback onCreateRoom;

  const LobbyButtons({Key key, this.onJoinRoom, this.onCreateRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 12, 4, 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Expanded(
            child: Center(
              child: Text(
                'Snap Rooms',
                maxLines: 2,
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
          Expanded(
            child: FancyButton(
              color: Colors.orange,
              size: 60,
              onPressed: onJoinRoom,
              child: Center(
                child: Text(
                  'Join Room',
                  style: fancy_button_style,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: FancyButton(
              color: Colors.red,
              size: 60,
              onPressed: onCreateRoom,
              child: Center(
                child: Text(
                  'Create Room',
                  style: fancy_button_style,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
