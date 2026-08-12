import 'dart:ui';

import 'package:hugeicons/hugeicons.dart';

class LevelStyle {
  final dynamic icon;
  final Color color;

  const LevelStyle({required this.icon, required this.color});

  static LevelStyle fromLevel(String level) {
    switch (level.toLowerCase()) {
      case 'advanced':
        return const LevelStyle(
          icon: HugeIcons.strokeRoundedAward01,
          color: Color(0xFF8B7AB8),
        );

      case 'intermediate':
        return const LevelStyle(
          icon: HugeIcons.strokeRoundedChartIncrease,
          color: Color(0xFF5B8DEF),
        );

      case 'beginner':
        return const LevelStyle(
          icon: HugeIcons.strokeRoundedRocket01,
          color: Color(0xFF65A88B),
        );

      default:
        return const LevelStyle(
          icon: HugeIcons.strokeRoundedSparkles,
          color: Color(0xFF8291A8),
        );
    }
  }
}
