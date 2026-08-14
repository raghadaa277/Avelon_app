import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class TopSourceInsightCard extends StatelessWidget {
  final String source;
  final double percentage;

  const TopSourceInsightCard({
    super.key,
    required this.source,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8F5FF), Color(0xFFFDFBFF)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE3FA)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 223, 102, 136), Color(0xFF5A34CC)],
              ),
            ),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedAnalytics01,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$source is your top source',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF252A35),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${percentage.toStringAsFixed(2)}% of your total views came from $source visits.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // const HugeIcon(
          //   icon: HugeIcons.strokeRoundedArrowRight01,
          //   size: 22,
          //   color: Color(0xFF5B36CC),
          // ),
        ],
      ),
    );
  }
}
