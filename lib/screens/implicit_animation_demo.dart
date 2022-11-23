import 'dart:async';

import 'package:animation_demo/screens/clock_painter.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ImplicitAnimationsDemo extends StatefulWidget {
  const ImplicitAnimationsDemo({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimationsDemo> createState() => _ImplicitAnimationsDemoState();
}

class _ImplicitAnimationsDemoState extends State<ImplicitAnimationsDemo> {
  bool shrinked = true;
  bool animatedShrinked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFd8def8),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWidget(),
            _buildAnimatedWidget(),
          ],
        ));
  }

  Padding _buildWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              shrinked = !shrinked;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(shrinked ? 0 : 20),
              color: shrinked ? Colors.red : Colors.amber,
            ),
            height: shrinked ? 100 : 200,
            width: shrinked ? 100 : 200,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Hello World",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildAnimatedWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              animatedShrinked = !animatedShrinked;
            });
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(animatedShrinked ? 0 : 20),
              color: animatedShrinked ? Colors.red : Colors.amber,
            ),
            duration: Duration(seconds: 2),
            height: animatedShrinked ? 100 : 200,
            width: animatedShrinked ? 100 : 200,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Animated Hello World",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
