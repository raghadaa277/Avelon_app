import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/models/Profile/user_sessions/get_user_daily_model.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/usgae_formate_widget.dart';

class DayUsageTile extends StatelessWidget {
  final DailyUsage day;

  const DayUsageTile({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConst.border),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day.date,
              style: const TextStyle(
                fontSize: 13,
                color: ColorConst.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                formatHoursToHms(day.totalHours),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ColorConst.primaryGreen,
                ),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                "${day.numberOfAppLaunches}",
                style: const TextStyle(
                  fontSize: 13,
                  color: ColorConst.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
