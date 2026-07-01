import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class TipCard extends StatelessWidget {
  final String title;
  final String message;

  const TipCard({
    super.key,
    this.title = 'Keep it up!',
    this.message = 'You are consistent today. Keep building great habits. 🚀',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorConst.lightGreenBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: ColorConst.cardBg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              size: 17,
              color: ColorConst.primaryGreen,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: ColorConst.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: ColorConst.textGrey,
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
