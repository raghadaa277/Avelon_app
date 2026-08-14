import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class TotalViewsCard extends StatelessWidget {
  final int totalViews;

  const TotalViewsCard({super.key, required this.totalViews});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8E3F5)),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFF9F7FF), Color(0xFFF5F0FF)],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFEDE8F9)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6941C6).withOpacity(0.06),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedView,
              size: 36,
              color: Colors.pink[200],
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Views',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalViews',
                  style: const TextStyle(
                    fontSize: 42,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 216, 102, 155),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: 125,
            height: 90,
            child: CustomPaint(painter: _ViewsLinePainter()),
          ),
        ],
      ),
    );
  }
}

class _ViewsLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(0, size.height * 0.72);
    path.cubicTo(
      size.width * 0.12,
      size.height * 0.55,
      size.width * 0.18,
      size.height * 0.88,
      size.width * 0.30,
      size.height * 0.62,
    );

    path.cubicTo(
      size.width * 0.42,
      size.height * 0.30,
      size.width * 0.50,
      size.height * 0.18,
      size.width * 0.62,
      size.height * 0.50,
    );

    path.cubicTo(
      size.width * 0.72,
      size.height * 0.76,
      size.width * 0.77,
      size.height * 0.25,
      size.width * 0.88,
      size.height * 0.38,
    );

    path.cubicTo(
      size.width * 0.94,
      size.height * 0.45,
      size.width * 0.96,
      size.height * 0.18,
      size.width,
      size.height * 0.08,
    );

    final linePaint = Paint()
      ..color = const Color(0xFF6842D8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()
      ..color = const Color(0xFF6842D8)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width, size.height * 0.08), 5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
