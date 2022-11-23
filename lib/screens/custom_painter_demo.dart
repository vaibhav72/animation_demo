import 'package:animation_demo/screens/clock_painter.dart';
import 'package:animation_demo/screens/resource_demo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;

class CustomPainterExplicitAnimationDemo extends StatefulWidget {
  const CustomPainterExplicitAnimationDemo({Key? key}) : super(key: key);

  @override
  State<CustomPainterExplicitAnimationDemo> createState() =>
      _CustomPainterExplicitAnimationDemoState();
}

class _CustomPainterExplicitAnimationDemoState
    extends State<CustomPainterExplicitAnimationDemo>
    with SingleTickerProviderStateMixin {
  late rive.RiveAnimationController _controller;

  /// Is the animation currently playing?

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: _initialDecoration(),
          height: 300,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomPaint(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(''),
              ),
              painter: CustomClockPainter(
                Duration(seconds: 60),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ShapeDecoration _initialDecoration() {
    return ShapeDecoration(
        shadows: const [
          BoxShadow(
              color: Color(0xFFb5bad0), offset: Offset(25, 25), blurRadius: 50),
          BoxShadow(
              color: Color(0xFFfbffff),
              offset: Offset(-25, -25),
              blurRadius: 50),
        ],
        gradient: const LinearGradient(
            transform: GradientRotation(2.531),
            colors: [Color(0xFFc2c8df), Color(0xFFe7eeff)]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(150)));
  }
}
