import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/models/Profile/user_sessions/get_user_daily_model.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/day_usage_widget.dart';

class SessionsList extends StatelessWidget {
  final String subtitleLabel;
  final List<DailyUsage> days;
  final ValueChanged<DailyUsage>? onDayTap;

  const SessionsList({
    super.key,
    required this.subtitleLabel,
    required this.days,
    this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConst.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ColorConst.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sessions ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: ColorConst.textDark,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            "All acctivity sessions for $subtitleLabel",
            style: const TextStyle(color: ColorConst.textGrey, fontSize: 12),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: ColorConst.lightGreenBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Date",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Text(
                      "Daily Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Text(
                      "Launches",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          if (days.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  "No usage found",
                  style: TextStyle(color: ColorConst.textGrey),
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: days.length,
              itemBuilder: (context, index) {
                return DayUsageTile(day: days[index]);
              },
            ),
        ],
      ),
    );
  }
}
