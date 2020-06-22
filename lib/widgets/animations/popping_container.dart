import 'package:flutter/material.dart';
import 'animation_widgets.dart'; // See my code reference for this gist

class PoppingContainer extends StatefulWidget {
  final Widget child;
  final bool visible;
  final int delay;
  const PoppingContainer({
    this.child,
    this.visible = true,
    this.delay = 1000,
  });

  @override
  State<StatefulWidget> createState() => PoppingContainerState();
}

class PoppingContainerState extends State<PoppingContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      tweenInit: Tween(begin: 1.0, end: 1.0),
      tween: Tween(
          begin: 0.0,
          end: widget.visible ? 1.0 : 0.0), // Update scale dynamically
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      delay: Duration(seconds: widget.delay),
      child: widget.child,
    );
  }
}
