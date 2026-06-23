import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/onboarding_model.dart';

({IconData icon, Color color}) _inspirationStyle(String name) {
  switch (name.toLowerCase()) {
    case 'curiosity':
      return (icon: Icons.psychology_rounded, color: const Color(0xFF8B5CF6));
    case 'games':
      return (
        icon: Icons.sports_esports_rounded,
        color: const Color(0xFF3B82F6),
      );
    case 'money':
      return (icon: Icons.attach_money_rounded, color: const Color(0xFF10B981));
    case 'university':
      return (icon: Icons.school_rounded, color: const Color(0xFFF59E0B));
    case 'friends':
      return (icon: Icons.people_rounded, color: const Color(0xFFEC4899));
    case 'youtube':
      return (
        icon: Icons.play_circle_fill_rounded,
        color: const Color(0xFFFF0000),
      );
    case 'movies':
      return (icon: Icons.movie_rounded, color: const Color(0xFFF97316));
    default:
      return (icon: Icons.star_rounded, color: const Color(0xFF6B7280));
  }
}

class InspirationChip extends StatelessWidget {
  final InspirationSourcesModel inspiration;
  final bool isSelected;
  final VoidCallback onTap;

  const InspirationChip({
    super.key,
    required this.inspiration,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (inspiration.name.toLowerCase() == 'other')
      return const SizedBox.shrink();

    final style = _inspirationStyle(inspiration.name);

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
                inspiration.label.isNotEmpty
                    ? inspiration.label
                    : inspiration.name,
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
