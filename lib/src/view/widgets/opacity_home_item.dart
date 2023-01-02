import 'package:flutter/material.dart';

class OpacityHomeItem extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> animation;
  final Widget widget;

  OpacityHomeItem(
      {required this.controller,
      required this.animation,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
        child: widget);
  }
}
