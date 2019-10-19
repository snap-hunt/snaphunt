import 'package:flutter/material.dart';
import 'package:snaphunt/widgets/fancy_button.dart';

class Lobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FancyButton(
          child: Text(
            "Back",
            style: TextStyle(color: Colors.white),
          ),
          size: 50,
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

class LobbyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(),
    );
  }
}

class LobbyListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
