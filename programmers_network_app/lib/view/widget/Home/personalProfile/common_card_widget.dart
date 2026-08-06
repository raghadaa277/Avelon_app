import 'package:flutter/material.dart';

class CommonInterestCard extends StatelessWidget {
  final int count;
  final int percentage;

  const CommonInterestCard({
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
        mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.favorite_border, color: Colors.orange),
          ),
          const SizedBox(height: 10),

          const Text(
            "Common Interests",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          Text(
            "$count",

            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),

          Text(
            "$percentage% of your total interests",

            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
