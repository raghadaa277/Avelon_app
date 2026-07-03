import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class PublishOptionCard extends StatelessWidget {
  final List<List> icon;
  final String title;
  final String subtitle;
  final bool selected;

  const PublishOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? ColorConst.colorButton : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          HugeIcon(icon: icon, color: ColorConst.colorButton, size: 22),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? ColorConst.colorButton : Colors.grey,
          ),
        ],
      ),
    );
  }
}
