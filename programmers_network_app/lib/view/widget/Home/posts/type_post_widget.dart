import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/posts/create_post_model.dart';

({IconData icon, Color color}) _typePostStyle(String name) {
  switch (name.toLowerCase()) {
    case 'article':
      return (icon: Icons.article_outlined, color: const Color(0xFF2563EB));

    case 'problem':
      return (
        icon: Icons.report_problem_outlined,
        color: const Color(0xFFEF4444),
      );

    case 'question':
      return (icon: Icons.help_outline, color: const Color(0xFFF59E0B));

    case 'project':
      return (icon: Icons.work_outline, color: const Color(0xFF10B981));

    case 'poll':
      return (icon: Icons.poll_outlined, color: const Color(0xFF8B5CF6));

    default:
      return (icon: Icons.description_outlined, color: Colors.grey);
  }
}

class TypePostChip extends StatelessWidget {
  final PostType type;
  final bool isSelected;
  final VoidCallback onTap;

  const TypePostChip({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = _typePostStyle(type.type);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? style.color.withValues(alpha: 0.06)
              : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? style.color : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: style.color.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(style.icon, color: style.color, size: 19),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                type.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: const Color(0xFF374151),
                ),
              ),
            ),

            if (isSelected)
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: style.color,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
