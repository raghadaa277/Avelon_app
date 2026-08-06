import 'package:flutter/material.dart';

class OverallConnectionCard extends StatelessWidget {
  final int percentage;
  final String status;

  const OverallConnectionCard({
    super.key,

    required this.percentage,

    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(blurRadius: 15, color: Colors.grey.withOpacity(.15)),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Overall Connection",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),

          Text(
            "$percentage%",

            style: const TextStyle(
              fontSize: 55,

              fontWeight: FontWeight.bold,

              color: Colors.deepPurple,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(.1),

              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              status,

              style: const TextStyle(
                color: Colors.deepPurple,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Text(
            "You have a $status connection with this user.",

            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
