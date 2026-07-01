import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class StatsSummary extends StatelessWidget {
  final String totalTimeLabel;
  final int appLaunchesCount;

  const StatsSummary({
    super.key,
    required this.totalTimeLabel,
    required this.appLaunchesCount,
  });

  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: ColorConst.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorConst.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorConst.iconBgGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: ColorConst.primaryGreen),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11.5,
                color: ColorConst.textGrey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: ColorConst.textDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _statCard(
            icon: Icons.access_time_rounded,
            label: 'Total Time',
            value: totalTimeLabel,
          ),
          _statCard(
            icon: Icons.play_circle_outline,
            label: 'App Launches',
            value: '$appLaunchesCount',
          ),
        ],
      ),
    );
  }
}
