import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:programmers_network_app/data/models/Home/growth/get_post_audience_model.dart';

class AudienceBalanceWidget extends StatelessWidget {
  final GetPostAudienceModel data;

  const AudienceBalanceWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final difference = (data.followersPercentage - data.nonFollowersPercentage)
        .abs();

    final bool isBalanced = difference <= 15;

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFF4FBEA),
        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFDCEEC8)),
      ),

      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,

            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 60, 103),
              shape: BoxShape.circle,
            ),

            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedAnalyticsUp,
                size: 23,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  isBalanced ? 'Great Audience Balance!' : 'Audience Overview',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  isBalanced
                      ? 'You have a balanced mix of followers and non-followers engaging with your content.'
                      : 'Your content is reaching different audience groups.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.35,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          const _BalanceIcon(),
        ],
      ),
    );
  }
}

class _BalanceIcon extends StatelessWidget {
  const _BalanceIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 45,

      child: CustomPaint(painter: _BalancePainter()),
    );
  }
}

class _BalancePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF78B836)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFF78B836)
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;

    canvas.drawLine(Offset(centerX, 5), Offset(centerX, 34), paint);

    canvas.drawLine(Offset(8, 15), Offset(size.width - 8, 15), paint);

    final left = Path()
      ..moveTo(8, 15)
      ..lineTo(20, 15)
      ..lineTo(14, 28)
      ..close();

    final right = Path()
      ..moveTo(size.width - 8, 15)
      ..lineTo(size.width - 20, 15)
      ..lineTo(size.width - 14, 28)
      ..close();

    canvas.drawPath(left, fillPaint);
    canvas.drawPath(right, fillPaint);

    canvas.drawCircle(Offset(17, 8), 6, fillPaint);

    canvas.drawCircle(Offset(size.width - 17, 8), 6, fillPaint);

    final triangle = Path()
      ..moveTo(centerX, 34)
      ..lineTo(centerX - 7, 44)
      ..lineTo(centerX + 7, 44)
      ..close();

    canvas.drawPath(triangle, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
