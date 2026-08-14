import 'package:flutter/material.dart';

class MiniChartPainter extends CustomPainter {
  final bool isIncrease;
  final bool isDecrease;

  MiniChartPainter({required this.isIncrease, required this.isDecrease});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    if (isDecrease) {
      paint.color = const Color(0xFFE05272);
    } else if (isIncrease) {
      paint.color = const Color(0xFF35BF82);
    } else {
      paint.color = const Color(0xFF9CA3AF);
    }

    final path = Path();

    if (isDecrease) {
      path.moveTo(2, 8);
      path.lineTo(18, 15);
      path.lineTo(30, 19);
      path.lineTo(43, 29);
      path.lineTo(56, 33);
      path.lineTo(70, 40);
      path.lineTo(84, 43);
      path.lineTo(98, 49);
    } else if (isIncrease) {
      path.moveTo(2, 45);
      path.lineTo(15, 39);
      path.lineTo(27, 40);
      path.lineTo(40, 30);
      path.lineTo(52, 32);
      path.lineTo(65, 21);
      path.lineTo(77, 24);
      path.lineTo(88, 13);
      path.lineTo(98, 8);
    } else {
      path.moveTo(2, 30);
      path.lineTo(98, 30);
    }

    canvas.drawPath(path, paint);

    if (isIncrease || isDecrease) {
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = paint.color.withOpacity(0.06);

      final fillPath = Path.from(path);

      fillPath.lineTo(size.width, size.height);
      fillPath.lineTo(0, size.height);
      fillPath.close();

      canvas.drawPath(fillPath, fillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant MiniChartPainter oldDelegate) {
    return oldDelegate.isIncrease != isIncrease ||
        oldDelegate.isDecrease != isDecrease;
  }
}
