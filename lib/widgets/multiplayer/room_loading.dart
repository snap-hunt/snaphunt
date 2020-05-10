import 'package:flutter/material.dart';

class RoomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('Retrieving game')
        ],
      ),
    );
  }
}
