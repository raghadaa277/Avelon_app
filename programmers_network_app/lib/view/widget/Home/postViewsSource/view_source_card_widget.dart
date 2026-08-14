import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ViewSourceCard extends StatelessWidget {
  final String title;
  final int count;
  final double percentage;
  final List<List> icon;
  final Color color;
  final Color lightColor;

  const ViewSourceCard({
    super.key,
    required this.title,
    required this.count,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEAEAF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.025),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(11),
              ),
              child: HugeIcon(icon: icon, size: 22, color: color),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),

            const SizedBox(height: 3),

            Text(
              '$count',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              '${percentage.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: percentage / 100,
                minHeight: 5,
                backgroundColor: const Color(0xFFF0F0F4),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
