import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ViewsBySourceChart extends StatelessWidget {
  final int totalViews;

  final double feedPercentage;
  final double searchPercentage;
  final double profilePercentage;

  const ViewsBySourceChart({
    super.key,
    required this.totalViews,
    required this.feedPercentage,
    required this.searchPercentage,
    required this.profilePercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Views by Source',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
        ),

        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: 45,
            height: 3,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 102, 136),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 330,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(300, 300),
                painter: _ViewsDonutPainter(
                  feedPercentage: feedPercentage,
                  searchPercentage: searchPercentage,
                  profilePercentage: profilePercentage,
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$totalViews',
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  Text(
                    'Total Views',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),

              Positioned(
                left: 105,
                top: 90,
                child: _ChartIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  color: const Color(0xFF2F80ED),
                ),
              ),

              Positioned(
                right: 102,
                top: 91,
                child: _ChartIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  color: const Color.fromARGB(255, 223, 102, 136),
                ),
              ),

              Positioned(
                bottom: 42,
                child: _ChartIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: const Color(0xFF24B47E),
                ),
              ),

              Positioned(
                left: 88,
                top: 138,
                child: Text(
                  '${feedPercentage.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              Positioned(
                right: 82,
                top: 138,
                child: Text(
                  '${searchPercentage.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              Positioned(
                bottom: 62,
                child: Text(
                  '${profilePercentage.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChartIcon extends StatelessWidget {
  final List<List> icon;
  final Color color;

  const _ChartIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return HugeIcon(icon: icon, size: 28, color: Colors.white);
  }
}

class _ViewsDonutPainter extends CustomPainter {
  final double feedPercentage;
  final double searchPercentage;
  final double profilePercentage;

  _ViewsDonutPainter({
    required this.feedPercentage,
    required this.searchPercentage,
    required this.profilePercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = math.min(size.width, size.height) / 2 - 12;

    final values = [feedPercentage, searchPercentage, profilePercentage];

    final colors = [
      const Color.fromARGB(255, 223, 102, 136),
      const Color(0xFF3182E5),
      const Color(0xFF28B47D),
    ];

    double startAngle = -math.pi / 2;

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / 100) * math.pi * 2;

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 72
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle - 0.035,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }

    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius - 38, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _ViewsDonutPainter oldDelegate) {
    return oldDelegate.feedPercentage != feedPercentage ||
        oldDelegate.searchPercentage != searchPercentage ||
        oldDelegate.profilePercentage != profilePercentage;
  }
}
