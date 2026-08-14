import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AudienceTotalViewsCard extends StatelessWidget {
  final int followersViews;
  final int nonFollowersViews;

  const AudienceTotalViewsCard({
    super.key,
    required this.followersViews,
    required this.nonFollowersViews,
  });

  @override
  Widget build(BuildContext context) {
    final int totalViews = followersViews + nonFollowersViews;

    return Container(
      height: 150,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: const Color(0xFFE8ECE8)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF1FBE5),

              border: Border.all(color: const Color(0xFFE3F1D2)),
            ),

            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedView,
                size: 34,
                color: Color.fromARGB(255, 211, 60, 103),
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Text(
                  'Total Views',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF374151),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '$totalViews',
                  style: const TextStyle(
                    fontSize: 35,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF67A522),
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'All views from your content',
                  style: TextStyle(fontSize: 11.5, color: Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          const SizedBox(width: 105, height: 75, child: _MiniAudienceChart()),
        ],
      ),
    );
  }
}

class _MiniAudienceChart extends StatelessWidget {
  const _MiniAudienceChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _MiniAudienceChartPainter());
  }
}

class _MiniAudienceChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF83BE3D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();

    path.moveTo(2, size.height * .75);

    path.cubicTo(
      size.width * .15,
      size.height * .35,
      size.width * .22,
      size.height * .75,
      size.width * .35,
      size.height * .48,
    );

    path.cubicTo(
      size.width * .48,
      size.height * .18,
      size.width * .52,
      size.height * .72,
      size.width * .66,
      size.height * .35,
    );

    path.cubicTo(
      size.width * .78,
      size.height * .08,
      size.width * .82,
      size.height * .48,
      size.width,
      size.height * .12,
    );

    canvas.drawPath(path, paint);

    final dotPaint = Paint()
      ..color = const Color(0xFF67A522)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width, size.height * .12), 5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
