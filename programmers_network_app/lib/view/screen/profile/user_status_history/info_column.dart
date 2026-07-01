import 'package:flutter/material.dart';

class InfoColumn extends StatelessWidget {
  final String label;
  final String value;
  final String? sub;

  const InfoColumn({
    super.key,
    required this.label,
    required this.value,
    this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),

        if (sub != null)
          Text(sub!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
