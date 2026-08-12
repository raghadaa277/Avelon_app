import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_skills_model.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/level_section_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/summary_header_widget.dart';

class SkillsContent extends StatelessWidget {
  final List<UserSkill> skills;

  const SkillsContent({super.key, required this.skills});

  Map<String, List<UserSkill>> _groupByLevel(List<UserSkill> skills) {
    final Map<String, List<UserSkill>> grouped = {};

    for (final skill in skills) {
      final level = skill.level.trim().isEmpty
          ? 'undefined'
          : skill.level.toLowerCase().trim();

      grouped.putIfAbsent(level, () => []).add(skill);
    }

    return grouped;
  }

  int _levelOrder(String level) {
    switch (level.toLowerCase()) {
      case 'advanced':
        return 0;
      case 'intermediate':
        return 1;
      case 'beginner':
        return 2;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByLevel(skills);

    final sortedGroups = grouped.entries.toList()
      ..sort((a, b) => _levelOrder(a.key).compareTo(_levelOrder(b.key)));

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 35),
      children: [
        SummaryHeader(totalCount: skills.length, groups: grouped),

        const SizedBox(height: 24),

        ...sortedGroups.map(
          (entry) => LevelSection(level: entry.key, skills: entry.value),
        ),
      ],
    );
  }
}
