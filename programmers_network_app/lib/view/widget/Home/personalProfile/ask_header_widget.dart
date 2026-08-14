import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AskQuestionHeaderWidget extends StatelessWidget {
  const AskQuestionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF0FDF4), Color(0xFFFFF1F2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),

      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedMessageQuestion,
                size: 30,
                color: Color(0xFF65A30D),
              ),
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We're here to help!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),

                SizedBox(height: 5),

                Text(
                  'Ask your question and get helpful answers from the community.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
