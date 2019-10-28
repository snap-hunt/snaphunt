import 'package:flutter/material.dart';
import 'package:snaphunt/widgets/common/fancy_alert_dialog.dart';

void showAlertDialog({BuildContext context, String title, String body}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => FancyAlertDialog(
      title: title,
      body: body,
    ),
  );
}
