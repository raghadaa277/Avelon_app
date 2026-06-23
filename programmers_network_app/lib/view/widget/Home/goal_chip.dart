import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/onboarding_model.dart';

({IconData icon, Color color}) _goalStyle(String name) {
  switch (name.toLowerCase()) {
    case 'learn programming':
    case 'learn_programming':
      return (icon: Icons.menu_book_rounded, color: const Color(0xFF3B82F6));
    case 'help others':
    case 'help_others':
      return (
        icon: Icons.volunteer_activism_rounded,
        color: const Color(0xFFEC4899),
      );
    case 'build network':
    case 'build_network':
      return (icon: Icons.hub_rounded, color: const Color(0xFF8B5CF6));
    case 'find teammates':
    case 'find_teammates':
      return (icon: Icons.group_rounded, color: const Color(0xFF06B6D4));
    case 'share projects':
    case 'share_projects':
      return (
        icon: Icons.rocket_launch_rounded,
        color: const Color(0xFFF97316),
      );
    case 'find job':
    case 'find_job':
      return (icon: Icons.work_rounded, color: const Color(0xFF0A66C2));
    case 'freelancing':
      return (icon: Icons.laptop_mac_rounded, color: const Color(0xFF10B981));
    default:
      return (icon: Icons.star_rounded, color: const Color(0xFF6B7280));
  }
}

class GoalChip extends StatelessWidget {
  final GoalsModel goal;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalChip({
    super.key,
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (goal.name.toLowerCase() == 'other') return const SizedBox.shrink();

    final style = _goalStyle(goal.name);

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
                color: style.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(style.icon, size: 19, color: style.color),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                goal.label.isNotEmpty ? goal.label : goal.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF111827)
                      : const Color(0xFF374151),
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: style.color,
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
