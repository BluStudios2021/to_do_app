import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.reverseDuration = const Duration(milliseconds: 250),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration reverseDuration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      value: 0.0,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.reverse();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeScaleTransition(
      animation: _controller,
      child: widget.child,
    );
  }
}
