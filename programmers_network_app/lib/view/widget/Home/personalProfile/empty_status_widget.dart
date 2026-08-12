import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedPackageOpen,
            size: 64,
            color: Colors.pink,
          ),
          const SizedBox(height: 12),
          Text(
            'No skills added yet',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
