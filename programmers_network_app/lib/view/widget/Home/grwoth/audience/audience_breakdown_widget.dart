import 'dart:math';

import 'package:flutter/material.dart';

import 'package:programmers_network_app/data/models/Home/growth/get_post_audience_model.dart';

class AudienceBreakdownWidget extends StatelessWidget {
  final GetPostAudienceModel data;

  const AudienceBreakdownWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.followersViews + data.nonFollowersViews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          'Views by Audience',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Breakdown of views by your audience type',
          style: TextStyle(fontSize: 12.5, color: Colors.grey.shade500),
        ),

        const SizedBox(height: 18),

        SizedBox(
          height: 285,
          child: Stack(
            alignment: Alignment.center,

            children: [
              CustomPaint(
                size: const Size(240, 240),
                painter: _AudienceDonutPainter(
                  followersPercentage: data.followersPercentage,
                  nonFollowersPercentage: data.nonFollowersPercentage,
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$total',
                    style: const TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF111827),
                    ),
                  ),

                  const Text(
                    'Total Views',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                ],
              ),

              Positioned(
                left: 0,
                top: 98,
                child: _AudiencePercentage(
                  percentage: data.followersPercentage,
                  label: 'Followers',
                  color: Color.fromARGB(255, 211, 60, 103),
                  alignRight: true,
                ),
              ),

              Positioned(
                right: 0,
                top: 98,
                child: _AudiencePercentage(
                  percentage: data.nonFollowersPercentage,
                  label: 'Non-followers',
                  color: const Color(0xFF72AD2C),
                  alignRight: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AudiencePercentage extends StatelessWidget {
  final double percentage;
  final String label;
  final Color color;
  final bool alignRight;

  const _AudiencePercentage({
    required this.percentage,
    required this.label,
    required this.color,
    required this.alignRight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,

      child: Column(
        crossAxisAlignment: alignRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,

        children: [
          Text(
            '${percentage.toStringAsFixed(2)}%',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),

          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),

          const SizedBox(height: 7),

          Row(
            mainAxisAlignment: alignRight
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,

            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),

              const SizedBox(width: 4),

              Container(width: 38, height: 1, color: color.withOpacity(.3)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AudienceDonutPainter extends CustomPainter {
  final double followersPercentage;
  final double nonFollowersPercentage;

  _AudienceDonutPainter({
    required this.followersPercentage,
    required this.nonFollowersPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width * .38;

    final backgroundPaint = Paint()
      ..color = const Color(0xFFF1F3F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 42;

    canvas.drawCircle(center, radius, backgroundPaint);

    final followerPaint = Paint()
      ..color = const Color(0xFF72AD2C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 42
      ..strokeCap = StrokeCap.butt;

    final nonFollowerPaint = Paint()
      ..color = const Color(0xFF9BCB54)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 42
      ..strokeCap = StrokeCap.butt;

    const startAngle = -1.5708;

    final followerSweep = (followersPercentage / 100) * 6.283185;

    final nonFollowerSweep = (nonFollowersPercentage / 100) * 6.283185;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      followerSweep,
      false,
      followerPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + followerSweep,
      nonFollowerSweep,
      false,
      nonFollowerPaint,
    );

    final separatorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final separatorAngle = startAngle + followerSweep;

    final inner = radius - 21;
    final outer = radius + 21;

    canvas.drawLine(
      Offset(
        center.dx + inner * cos(separatorAngle),
        center.dy + inner * sin(separatorAngle),
      ),
      Offset(
        center.dx + outer * cos(separatorAngle),
        center.dy + outer * sin(separatorAngle),
      ),
      separatorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _AudienceDonutPainter oldDelegate) {
    return oldDelegate.followersPercentage != followersPercentage ||
        oldDelegate.nonFollowersPercentage != nonFollowersPercentage;
  }
}

// class _UnusedIcon extends StatelessWidget {
//   const _UnusedIcon();

//   @override
//   Widget build(BuildContext context) {
//     return const HugeIcon(
//       icon: HugeIcons.strokeRoundedUserGroup,
//       size: 20,
//       color: Color(0xFF72AD2C),
//     );
//   }
// }
