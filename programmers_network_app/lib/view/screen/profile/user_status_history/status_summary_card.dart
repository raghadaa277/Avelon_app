import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/models/Profile/user_status_history_model.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/session_card.dart';

import 'card_title.dart';

import 'summary_item.dart';

class StatusSummaryCard extends StatelessWidget {
  final StatusSummaryModel summary;

  const StatusSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardTitle("Status Summary"),

          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: SummaryItem(
                  label: "Active",
                  count: summary.activeCount,
                  icon: Icons.check_circle,
                  color: green,
                ),
              ),

              SizedBox(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: SummaryItem(
                  label: "Inactive",
                  count: summary.inactiveCount,
                  icon: Icons.error,
                  color: orange,
                ),
              ),

              SizedBox(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: SummaryItem(
                  label: "Suspended",
                  count: summary.suspendedCount,
                  icon: Icons.pause_circle_filled,
                  color: deepOrange,
                ),
              ),

              SizedBox(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: SummaryItem(
                  label: "Banned",
                  count: summary.bannedCount,
                  icon: Icons.cancel,
                  color: red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
