import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class InfoPill extends StatelessWidget {
  final List<List<dynamic>> icon;
  final Color color;
  final String label;
  final bool filled;
  final bool iconOnly;

  const InfoPill({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    this.filled = false,
    this.iconOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (iconOnly) {
      return Tooltip(
        message: label,
        child: HugeIcon(icon: icon, color: color, size: 16),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: filled ? color.withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: filled ? null : Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(icon: icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
