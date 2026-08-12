import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_skills_model.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/level_style_widget.dart';

import 'package:programmers_network_app/view/widget/Home/personalProfile/skill_card_widget.dart';

class LevelSection extends StatelessWidget {
  final String level;
  final List<UserSkill> skills;

  const LevelSection({super.key, required this.level, required this.skills});

  String _formatLevel(String value) {
    if (value.trim().isEmpty) {
      return 'Undefined';
    }

    final normalized = value.trim().toLowerCase();

    return normalized[0].toUpperCase() + normalized.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final style = LevelStyle.fromLevel(level);
    final formattedLevel = _formatLevel(level);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Level Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: style.color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: HugeIcon(icon: style.icon, size: 21, color: style.color),
              ),

              const SizedBox(width: 12),

              // Level Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedLevel,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      '${skills.length} '
                      '${skills.length == 1 ? 'skill' : 'skills'}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Count Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: style.color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  '${skills.length}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: style.color,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Skills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => SkillCard(skill: skill)).toList(),
          ),
        ],
      ),
    );
  }
}
