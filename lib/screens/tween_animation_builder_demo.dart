import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TweenAnimationDemo extends StatefulWidget {
  const TweenAnimationDemo({Key? key}) : super(key: key);

  @override
  State<TweenAnimationDemo> createState() => _TweenAnimationDemoState();
}

class _TweenAnimationDemoState extends State<TweenAnimationDemo> {
  Duration endValue = const Duration(seconds: 30);
  double beginValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFd8def8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNeuTimer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
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
                            height: MediaQuery.of(context).size.height * .5,
                            width: 300,
                            child: CupertinoTimerPicker(
                                onTimerDurationChanged: (duration) {
                              setState(() {
                                endValue = duration;
                                beginValue = 0;
                              });
                            }),
                          ),
                        ));
              },
              child: Container(
                decoration: _outerDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Choose Time'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Center _buildNeuTimer() {
    return Center(
        child: Container(
      height: 300,
      width: 300,
      decoration: _outerDecoration(),
      child: TweenAnimationBuilder(
          duration: Duration(seconds: endValue.inSeconds),
          tween: Tween<double>(
              begin: beginValue, end: endValue.inSeconds.toDouble()),
          builder: (context, double value, snapshot) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 290,
                          width: 290,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 3,
                            value: value / endValue.inSeconds.toDouble(),
                          ),
                        )),
                    Text(
                      "${(endValue.inSeconds - value.toInt()) ~/ 60}:${value.toInt()}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }),
    ));
  }

  ShapeDecoration _outerDecoration() {
    return ShapeDecoration(
        shadows: const [
          BoxShadow(
              color: Color(0xFFFFFFFF), offset: Offset(-5, -5), blurRadius: 22),
          BoxShadow(
              color: Color(0xFFadb2c6), offset: Offset(5, 5), blurRadius: 22),
        ],
        gradient: const LinearGradient(
            transform: GradientRotation(2.531),
            colors: [Color(0xFFe7eeff), Color(0xFFc2c8df)]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(150)));
  }
}
