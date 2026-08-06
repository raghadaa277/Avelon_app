import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hugeicons/hugeicons.dart';

class ConnectionHeaderWidget extends StatelessWidget {
  const ConnectionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: InkWell(child: Icon(Icons.arrow_back), onTap: Get.back),
            ),
          ],
        ),

        const SizedBox(height: 20),

        HugeIcon(
          icon: HugeIcons.strokeRoundedAnalytics01,
          size: 45,
          color: Colors.deepPurple,
        ),

        const SizedBox(height: 15),

        const Text(
          "Connection Insights",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        // Text(
        //   "How you and $userName are connected",
        //   style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        // ),
      ],
    );
  }
}
