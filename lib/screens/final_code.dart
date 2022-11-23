import 'package:animation_demo/screens/clock_painter.dart';
import 'package:animation_demo/screens/resource_demo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;

class FinalApp extends StatefulWidget {
  const FinalApp({Key? key}) : super(key: key);

  @override
  State<FinalApp> createState() => _FinalAppState();
}

class _FinalAppState extends State<FinalApp>
    with SingleTickerProviderStateMixin {
  late rive.RiveAnimationController _controller;

  /// Is the animation currently playing?
  bool _isPlaying = false;
  Duration endValue = const Duration(seconds: 30);
  late DecorationTween decorationTween;
  late AnimationController controller;
  @override
  void initState() {
    decorationTween =
        DecorationTween(begin: _initialDecoration(), end: _endDecoration());
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: endValue.inSeconds));
    _controller = rive.OneShotAnimation(
      'lookUp',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );

    controller.addListener(() {
      controller.isCompleted
          ? _controller.isActive = true
          : print("not completed");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.value);
    return Scaffold(
        body: AnimatedBuilder(
            animation: CurvedAnimation(parent: controller, curve: Curves.ease),
            builder: (context, widget) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.tealAccent, Colors.white],
                        stops: [0, controller.value])),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: rive.RiveAnimation.asset(
                          'assets/flutter.riv',
                          animations: const ['idle', 'lookUp', 'slowDance'],
                          controllers: [_controller],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _getTimeWidget(),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                controller.isAnimating
                                    ? controller.stop()
                                    : {
                                        controller.reset(),
                                        controller.forward()
                                      };
                              },
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                height: 300,
                                width: 300,
                                decoration: controller.isCompleted
                                    ? _endDecoration()
                                    : _initialDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(''),
                                    ),
                                    painter: CustomClockPainter(
                                      Duration(
                                          seconds: (controller
                                                      .lastElapsedDuration
                                                      ?.inSeconds !=
                                                  null
                                              ? (endValue.inSeconds -
                                                      controller
                                                          .lastElapsedDuration!
                                                          .inSeconds)
                                                  .toInt()
                                              : 0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                controller.reset();
                                var value = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          actions: [
                                            MaterialButton(
                                              color: Colors.tealAccent,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK"),
                                            )
                                          ],
                                          content: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .5,
                                            width: 300,
                                            child: CupertinoTimerPicker(
                                                onTimerDurationChanged:
                                                    (duration) {
                                              setState(() {
                                                endValue = duration;
                                              });
                                            }),
                                          ),
                                        ));
                                controller.duration = endValue;
                                controller.reset();
                                controller.forward();
                              },
                              child: Container(
                                decoration: _initialDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Choose Time'),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Text _getTimeWidget() {
    return Text(
      "${(controller.lastElapsedDuration?.inSeconds != null ? (endValue.inSeconds - controller.lastElapsedDuration!.inSeconds).toInt() : 0) ~/ 3600}:  ${((controller.lastElapsedDuration?.inSeconds != null ? (endValue.inSeconds - controller.lastElapsedDuration!.inSeconds).toInt() : 0) ~/ 60) % 60}:${((controller.lastElapsedDuration?.inSeconds != null ? (endValue.inSeconds - controller.lastElapsedDuration!.inSeconds).toInt() : 0)) % 60}",
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

  ShapeDecoration _endDecoration() {
    return ShapeDecoration(
        shadows: const [
          BoxShadow(
              color: Color(0xFFb5bad0), offset: Offset(25, 25), blurRadius: 50),
          BoxShadow(
              color: Color(0xFFfbffff),
              offset: Offset(-25, -25),
              blurRadius: 50),
        ],
        gradient: const LinearGradient(colors: [
          Colors.tealAccent,
          Color(0xFFe7eeff),
        ]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(150)));
  }

  ShapeDecoration _innerDecoration() {
    return ShapeDecoration(
        shadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(-5, -5),
              blurRadius: 22),
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(5, 5),
              blurRadius: 22),
        ],
        gradient: const LinearGradient(
            transform: const GradientRotation(2.531),
            colors: [Color(0xFFe7eeff), Color(0xFFc2c8df)]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(150)));
  }
}
