import 'package:flutter/material.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/widgets/fancy_button.dart';

class CreateButtons extends StatelessWidget {
  final Function onCreate;

  const CreateButtons({Key key, this.onCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: FancyButton(
              child: Center(
                child: Text(
                  'Cancel',
                  style: fancy_button_style,
                ),
              ),
              color: Colors.blueGrey,
              size: 40,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: FancyButton(
              child: Center(
                child: Text(
                  'Create Room',
                  style: fancy_button_style,
                ),
              ),
              color: Colors.deepOrangeAccent,
              size: 40,
              onPressed: onCreate,
            ),
          ),
        ],
      ),
    );
  }
}
