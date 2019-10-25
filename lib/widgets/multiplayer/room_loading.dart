import 'package:flutter/material.dart';

class RoomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('Retrieving game')
        ],
      ),
    );
  }
}
