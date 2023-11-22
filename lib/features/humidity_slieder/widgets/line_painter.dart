import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:test_task/features/humidity_slieder/utils/humidity_configuration.dart';

class LinePainter extends CustomPainter {
  const LinePainter(this.horCenter, this.configuration);
  final HumidityConfiguration configuration;
  final double horCenter;

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final lineCount = (configuration.list.length - 1) * 5 + 1;

    final paddingTop = 10 * height / 100 + kNumberFontSize / 2;
    final paddingBottom = 11 * height / 100 + kNumberFontSize / 2;

    final lineStep = (height - paddingTop - paddingBottom) / (lineCount - 1);
    double val = paddingTop;
    final path = Path();

    for (int i = 0; i < lineCount; i++) {
      final isLong = i % 5 == 0;
      double startX = isLong ? 22 : 29;
      double endX = width;
      final distanceToCenter = (val - horCenter - 20).abs();
      if (distanceToCenter < 50) {
        final sin = distanceToCenter / 50;
        final angle = math.asin(sin);
        final cos = math.cos(angle);
        final delta = 30 * sin * cos * 1.05;
        startX -= delta;
        endX -= delta;
      }
      path
        ..moveTo(startX, val)
        ..lineTo(endX, val);
      val += lineStep;
    }

    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
