import 'package:flutter/material.dart';

// Removes list overscroll animation
// https://stackoverflow.com/questions/51119795/how-to-remove-scroll-glow
class NoOverFlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}