import 'package:flutter/material.dart';

class ConnectionMeaningCard extends StatelessWidget {
  const ConnectionMeaningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        color: Colors.purple.withOpacity(.05),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "What does this mean?",

            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          Text(
            "Your connection is very low. Keep interacting, follow similar topics, and engage more to strengthen your bond.",

            style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
