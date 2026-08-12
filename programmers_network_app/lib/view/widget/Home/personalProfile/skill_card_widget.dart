import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_skills_model.dart';

class SkillCard extends StatelessWidget {
  final UserSkill skill;

  const SkillCard({super.key, required this.skill});

  String _formatSkill(String value) {
    if (value.trim().isEmpty) {
      return 'Unknown';
    }

    return value
        .trim()
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? word : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final primary = ColorConst.colorButton;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
          ),

          const SizedBox(width: 8),

          Text(
            _formatSkill(skill.skill),
            style: const TextStyle(
              color: Color(0xFF334155),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
