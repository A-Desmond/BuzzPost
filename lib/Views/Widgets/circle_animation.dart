import 'package:flutter/cupertino.dart';


class CircleAnimation extends StatefulWidget {
  final Widget child;
  const CircleAnimation({super.key, required this.child});

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
  _controller = AnimationController(vsync:  this, duration: const Duration(milliseconds: 5000)) ;
  _controller.forward();
  _controller.repeat();
  }
  @override
  void dispose() {
 super.dispose();
 _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: widget.child,
      );
  }
}