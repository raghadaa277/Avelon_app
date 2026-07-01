import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Profile/user_status_history_model.dart';

import 'package:programmers_network_app/view/screen/profile/user_status_history/status_history_item.dart';

class StatusHistorySection extends StatefulWidget {
  const StatusHistorySection({super.key, required this.histories});
  final List<StatusHistory> histories;

  @override
  State<StatusHistorySection> createState() => _StatusHistorySectionState();
}

class _StatusHistorySectionState extends State<StatusHistorySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status History',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          const Text(
            'A timeline of all status changes for this user.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          if (widget.histories.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'No records found.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ...widget.histories.asMap().entries.map(
            (e) => StatusHistoryItem(
              item: e.value,
              isLast: e.key == widget.histories.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}
