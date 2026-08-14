import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class OverviewInsightCardWidget extends StatelessWidget {
  final double averageViews;

  const OverviewInsightCardWidget({super.key, required this.averageViews});

  @override
  Widget build(BuildContext context) {
    const lime = Color.fromARGB(255, 206, 241, 130);
    const pink = Color(0xFFF7A8C4);
    const purple = Color(0xFF7C5CFC);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [lime.withOpacity(.18), pink.withOpacity(.10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: lime.withOpacity(.45)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedIdea01,
                    size: 32,
                    color: purple,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Insights',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: purple,
                      ),
                    ),

                    const SizedBox(height: 10),

                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.7,
                          color: Colors.grey.shade800,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Each user viewed an average of ',
                          ),
                          TextSpan(
                            text: averageViews.toStringAsFixed(2),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: purple,
                            ),
                          ),
                          const TextSpan(text: ' times during this period.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Small visual chart
          _MiniViewsChart(color: purple),
        ],
      ),
    );
  }
}

class _MiniViewsChart extends StatelessWidget {
  final Color color;

  const _MiniViewsChart({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.65),
        borderRadius: BorderRadius.circular(16),
      ),
      child: CustomPaint(
        painter: _ViewsChartPainter(color),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(.15), blurRadius: 8),
                  ],
                ),
                child: Center(
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedView,
                    size: 24,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewsChartPainter extends CustomPainter {
  final Color color;

  _ViewsChartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final points = [
      Offset(size.width * .04, size.height * .75),
      Offset(size.width * .20, size.height * .48),
      Offset(size.width * .36, size.height * .56),
      Offset(size.width * .50, size.height * .32),
      Offset(size.width * .66, size.height * .38),
      Offset(size.width * .82, size.height * .26),
      Offset(size.width * .92, size.height * .10),
    ];

    final path = Path();

    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ViewsChartPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
