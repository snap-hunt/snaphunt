import 'package:flutter/material.dart';
import 'package:snaphunt/widgets/animations/animation_widgets.dart';

class AnimateScaleItem extends AnimatedScale {
  AnimateScaleItem({Widget child, int delay = 1000, int duration = 800})
      : super(
          child: child,
          curve: Curves.elasticOut,
          delay: Duration(milliseconds: delay),
          duration: Duration(milliseconds: duration),
        );
}
