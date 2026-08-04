import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animation/search_loading.json',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 10),
          const Text(
            "No results found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "Try searching for another company",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
