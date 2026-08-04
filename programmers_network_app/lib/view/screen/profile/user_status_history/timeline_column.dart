import 'package:flutter/material.dart';

class TimelineColumn extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? child;

  const TimelineColumn({
    super.key,
    required this.label,
    this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),

        const SizedBox(height: 4),

        child ??
            Text(
              value ?? "-",
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
      ],
    );
  }
}
