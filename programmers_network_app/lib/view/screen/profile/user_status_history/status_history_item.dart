import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/helper/status_color.dart';
import 'package:programmers_network_app/data/models/Profile/user_status_history_model.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/status_badge.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/timeline_column.dart';

class StatusHistoryItem extends StatelessWidget {
  final StatusHistory item;
  final bool isLast;

  const StatusHistoryItem({
    super.key,
    required this.item,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final color = statusColor(item.status);
    final icon = statusIcon(item.status);
    final ongoing = item.endedAt == null;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 38,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TimelineColumn(
                          label: "Status",
                          child: StatusBadge(status: item.status),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TimelineColumn(
                          label: "Reason",
                          value: item.reason.isEmpty ? "-" : item.reason,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TimelineColumn(
                          label: "Started At",
                          value: formatDateTime(item.startedAt),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TimelineColumn(
                          label: "Ended At",
                          value: ongoing ? "-" : formatDateTime(item.endedAt),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
