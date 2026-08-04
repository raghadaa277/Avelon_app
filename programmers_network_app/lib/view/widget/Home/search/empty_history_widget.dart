import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animation/no_history.json',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 10),
          const Text(
            "No search history yet",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "Your searches will appear here",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
