import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/onboarding_model.dart';

({IconData icon, Color color}) _sourceStyle(String name) {
  switch (name.toLowerCase()) {
    case 'instagram':
      return (icon: Icons.camera_alt, color: const Color(0xFFE1306C));
    case 'facebook':
      return (icon: Icons.facebook, color: const Color(0xFF1877F2));
    case 'linkedin':
      return (icon: Icons.work_rounded, color: const Color(0xFF0A66C2));
    case 'youtube':
      return (icon: Icons.play_circle_fill, color: const Color(0xFFFF0000));
    case 'tiktok':
      return (icon: Icons.music_note_rounded, color: const Color(0xFF010101));
    case 'google':
      return (icon: Icons.search_rounded, color: const Color(0xFF4285F4));
    case 'friend':
      return (icon: Icons.people_rounded, color: const Color(0xFF7C3AED));
    case 'university':
      return (icon: Icons.school_rounded, color: const Color(0xFFF59E0B));
    case 'github':
      return (icon: Icons.code_rounded, color: const Color(0xFF24292E));
    default:
      return (icon: Icons.more_horiz, color: const Color(0xFF6B7280));
  }
}

class SourceChip extends StatelessWidget {
  final SourcesModel source;
  final bool isSelected;
  final VoidCallback onTap;

  const SourceChip({
    super.key,
    required this.source,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (source.name.toLowerCase() == 'other') return const SizedBox.shrink();

    final style = _sourceStyle(source.name);

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
                source.label.isNotEmpty ? source.label : source.name,
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
