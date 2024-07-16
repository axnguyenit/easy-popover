import 'dart:math';

import 'package:flutter/material.dart';

// isosceles right triangle
class RoundedTrianglePainter extends CustomPainter {
  final double radius;
  final Color color;

  RoundedTrianglePainter({
    this.radius = 2.0,
    required this.color,
  });

  ///           A
  ///           △
  ///          /▽\
  ///         / ⎪ \
  ///        /  ⎪  \
  ///       /   ⎪   \
  ///      /    ⎪    \
  ///     /     ⎪     \
  ///    /     ◻︎⎪◻︎     \
  ///  B ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ C
  ///       hypotenuse
  ///
  @override
  void paint(Canvas canvas, Size size) {
    final hypotenuse = size.width;
    final height = hypotenuse * cos(45);
    final acuteAngles = atan(2 * height / hypotenuse);
    final S = radius / cos(acuteAngles);
    final L = radius * tan(acuteAngles);
    final h = L * sin(acuteAngles);
    final b = 2 * L * cos(acuteAngles);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final basePath = Path()
      ..moveTo(hypotenuse / 2, height)
      ..relativeLineTo(-hypotenuse / 2, 0)
      ..relativeLineTo(hypotenuse - (hypotenuse / 2 + b / 2), -height + h)
      ..relativeLineTo(b, 0)
      ..lineTo(hypotenuse, height)
      ..close;

    final arcRect = Rect.fromCenter(
      center: Offset(hypotenuse / 2, S),
      width: 2 * radius,
      height: 2 * radius,
    );

    final arcPath = Path()
      ..addArc(arcRect, pi + acuteAngles, 2 * acuteAngles)
      ..close;

    final completePath = Path.combine(PathOperation.union, basePath, arcPath);

    canvas.drawPath(completePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
