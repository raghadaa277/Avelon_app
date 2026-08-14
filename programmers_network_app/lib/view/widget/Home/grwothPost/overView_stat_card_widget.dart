import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class OverviewStatCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String description;
  final dynamic leadingIcon;
  final dynamic trailingIcon;
  final Color accentColor;
  final Color iconBackgroundColor;

  const OverviewStatCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.description,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.accentColor,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentColor.withOpacity(.25)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Center(
              child: HugeIcon(icon: leadingIcon, size: 38, color: accentColor),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF39445A),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 42,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: accentColor,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: HugeIcon(icon: trailingIcon, size: 30, color: accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
