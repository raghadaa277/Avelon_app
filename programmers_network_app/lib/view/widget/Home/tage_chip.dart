import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/onboarding_model.dart';
import 'package:programmers_network_app/view/widget/Home/tage_slider.dart';

class TagChip extends StatelessWidget {
  final TagsModel tag;
  final bool isSelected;
  final VoidCallback onTap;

  const TagChip({
    super.key,
    required this.tag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = tagStyle(tag.name);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? style.color.withValues(alpha: 0.08)
              : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected ? style.color : const Color(0xFFE5E7EB),
            width: isSelected ? 1.6 : 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: style.color.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(style.icon, size: 13, color: style.color),
            ),
            const SizedBox(width: 8),
            Text(
              tag.label.isNotEmpty ? tag.label : tag.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF111827)
                    : const Color(0xFF374151),
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Icon(Icons.check_circle_rounded, size: 15, color: style.color),
            ],
          ],
        ),
      ),
    );
  }
}
