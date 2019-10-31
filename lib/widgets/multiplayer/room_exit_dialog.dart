import 'package:flutter/material.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

class RoomExitDialog extends StatelessWidget {
  final String title;
  final String body;

  const RoomExitDialog({Key key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      elevation: 5,
      title: Center(
        child: Text(title),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: DialogFancyButtonExit(
                  text: 'OKAY',
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: DialogFancyButtonExit(
                  text: 'CANCEL',
                  color: Colors.blueGrey,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DialogFancyButtonExit extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  const DialogFancyButtonExit({
    Key key,
    this.text,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FancyButton(
      child: Center(
        child: Text(
          text,
          style: fancy_button_style,
        ),
      ),
      size: 50,
      color: color,
      onPressed: onPressed,
    );
  }
}
