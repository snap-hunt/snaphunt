import 'package:flutter/material.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

class FancyAlertDialog extends StatelessWidget {
  final String title;
  final String body;

  const FancyAlertDialog({Key key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      elevation: 5,
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 32, 24, 18),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 30),
          DialogFancyButtonExit(
            text: 'OKAY',
            color: Colors.orange,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

class DialogFancyButtonExit extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const DialogFancyButtonExit({
    Key key,
    this.text,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FancyButton(
      size: 60,
      color: color,
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: fancyButtonStyle,
        ),
      ),
    );
  }
}
