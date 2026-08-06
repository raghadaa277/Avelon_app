import 'package:flutter/material.dart';

class MutualFollowersCard extends StatelessWidget {
  final int count;
  final int percentage;

  const MutualFollowersCard({
    super.key,
    required this.count,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.people, color: Colors.green),
          ),

          const SizedBox(height: 10),

          const Text(
            "Mutual Followers",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          Text(
            "$count",
            style: const TextStyle(
              fontSize: 32, // كان 40
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          Text(
            "$percentage% of your total followers",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.green, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
