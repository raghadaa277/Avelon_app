import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/helper/status_color.dart';
import 'package:programmers_network_app/data/models/Profile/user_status_history_model.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/session_card.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/status_badge.dart';

import 'card_title.dart';
import 'info_column.dart';

import 'vertical_divider.dart';

class CurrentStatusCard extends StatelessWidget {
  final CurrentStatusModel current;

  const CurrentStatusCard({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardTitle("Current Status"),

          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusBadge(status: current.status),

                    const SizedBox(height: 8),

                    Text(
                      current.reason.isEmpty ? "-" : current.reason,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),

              const VerticalDividerWidget(),

              Expanded(
                flex: 4,
                child: InfoColumn(
                  label: "Status Since",
                  value: formatDateTime(current.startedAt),
                  sub: timeAgo(current.startedAt),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
