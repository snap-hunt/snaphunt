import 'package:flutter/material.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

class GameRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('game'),
      ),
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
