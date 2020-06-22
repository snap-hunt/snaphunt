import 'package:flutter/material.dart';

// Creates a popup with the given widget, a scale animation, and faded background.
Future<T> showPopupDialog<T>(BuildContext context, Widget child) {
  return showGeneralDialog<T>(
    context: context,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: false,
    useRootNavigator: true,
    pageBuilder: (BuildContext buildContext, _, __) =>
        SafeArea(child: Builder(builder: (BuildContext context) => child)),
    transitionBuilder: (context, animation, _, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.decelerate),
        child: child,
      );
    },
  );
}
