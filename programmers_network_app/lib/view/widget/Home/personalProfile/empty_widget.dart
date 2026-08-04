import 'package:flutter/material.dart';

class FollowersEmptyWidget extends StatelessWidget {
  const FollowersEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No users found", style: TextStyle(fontSize: 16)),
    );
  }
}
