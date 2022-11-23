import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ExplicitAnimationDemo extends StatefulWidget {
  const ExplicitAnimationDemo({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimationDemo> createState() => _ExplicitAnimationDemoState();
}

class _ExplicitAnimationDemoState extends State<ExplicitAnimationDemo>
    with SingleTickerProviderStateMixin {
  Duration endValue = const Duration(seconds: 20);
  late DecorationTween decorationTween;
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();

    decorationTween = DecorationTween(
        begin: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.red,
        ),
        end: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.amber,
        ))
      ..animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    controller.addListener(() {
      if (controller.lastElapsedDuration?.inSeconds == endValue.inSeconds)
        controller.stop();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedBuilder(
            animation: controller,
            builder: (context, widgetCHild) {
              return _buildTimer();
            }));
  }

  Center _buildTimer() {
    return Center(
        child: SizedBox(
      height: 300,
      width: 300,
      child: ScaleTransition(
        scale: controller,
        child: DecoratedBoxTransition(
            decoration: decorationTween.animate(controller),
            child: Center(
              child: Text(
                "${(controller.lastElapsedDuration?.inSeconds != null ? (endValue.inSeconds - controller.lastElapsedDuration!.inSeconds).toInt() : 0) ~/ 60}:${((controller.lastElapsedDuration?.inSeconds != null ? (endValue.inSeconds - controller.lastElapsedDuration!.inSeconds).toInt() : 0)) % 60}",
                style: TextStyle(fontSize: 20),
              ),
            )),
      ),
    ));
  }
}
