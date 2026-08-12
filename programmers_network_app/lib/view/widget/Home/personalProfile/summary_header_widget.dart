import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_skills_model.dart';

class SummaryHeader extends StatelessWidget {
  final int totalCount;
  final Map<String, List<UserSkill>> groups;

  const SummaryHeader({
    super.key,
    required this.totalCount,
    required this.groups,
  });

  @override
  Widget build(BuildContext context) {
    final primary = ColorConst.colorButton;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(15),
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedAward01,
              color: primary,
              size: 26,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Skills & Expertise',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '$totalCount ${totalCount == 1 ? 'skill' : 'skills'} '
                  'across ${groups.length} '
                  '${groups.length == 1 ? 'level' : 'levels'}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.09),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$totalCount',
              style: TextStyle(
                color: primary,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
