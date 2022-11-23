import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomClockPainter extends CustomPainter {
  final Duration duration;

  CustomClockPainter(
    this.duration,
  );

  @override
  void paint(Canvas canvas, Size size) {
    double borderWidth = 1;
    //clock radius
    final radius = min(size.width, size.height) / 2;
    //clock circumference
    // radius-2 2 here is the border width
    final double circumference = 2 * (radius) * pi;

    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawCircle(
        Offset(0, 0),
        radius,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.transparent);

    _paintTickMarks(canvas, size, 1);

    // // setup numbers
    final double bigTickWidth = circumference / 120;
    final double tickRadius = (radius - borderWidth - bigTickWidth);
    final double numberRadius = tickRadius - bigTickWidth * 3;

    _paintSecondHand(canvas, numberRadius, (radius - borderWidth) / 80);
  }

  void _paintTickMarks(Canvas canvas, Size size, double scaleFactor) {
    double r = size.width / 2;
    double tick = 5 * scaleFactor,
        mediumTick = 2.0 * tick,
        longTick = 3.0 * tick;
    double p = longTick + 4 * scaleFactor;
    Paint tickPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0 * scaleFactor;

    for (int i = 1; i <= 60; i++) {
      // default tick length is short
      double len = tick;
      if (i % 15 == 0) {
        // Longest tick on quarters (every 15 ticks)
        len = longTick;
      } else if (i % 5 == 0) {
        // Medium ticks on the '5's (every 5 ticks)
        len = mediumTick;
      }

      double angleFrom3 = getRadians((i * 6));

      // Get the angle from 3 O'Clock to this tick
      // Note: 3 O'Clock corresponds with zero angle in unit circle
      // Makes it easier to do the math.

      // print(
      //     "offset of $i is ${Offset(cos(angleFrom3) * (r - p + len), sin(angleFrom3) * (r - p + len))}");
      canvas.drawLine(
          Offset(
              cos(angleFrom3) * (r - p + len), sin(angleFrom3) * (r - p + len)),
          Offset(cos(angleFrom3) * (r - p), sin(angleFrom3) * (r - p)),
          tickPaint);
    }
  }

  void _paintSecondHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = duration.inSeconds - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius,
        sin(getRadians(angle * 6.0)) * radius);

    final secondHandPaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, secondHandPaint);
  }

  @override
  bool shouldRepaint(CustomClockPainter oldDelegate) {
    return duration != oldDelegate.duration;
  }

  static double getRadians(double angle) {
    return angle * pi / 180;
  }
}







// void _paintHourHand(Canvas canvas, double radius, double strokeWidth) {
//     double angle = duration.inHours % 12 + duration.inMinutes / 60.0 - 3;
//     Offset handOffset = Offset(cos(getRadians(angle * 30)) * radius,
//         sin(getRadians(angle * 30)) * radius);
//     final hourHandPaint = Paint()
//       ..color = Colors.black
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = strokeWidth;
//     canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
//   }

//   /// draw minute hand
//   void _paintMinuteHand(Canvas canvas, double radius, double strokeWidth) {
//     double angle = duration.inMinutes - 15.0;
//     Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius,
//         sin(getRadians(angle * 6.0)) * radius);
//     final hourHandPaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = strokeWidth;
//     canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
//   }