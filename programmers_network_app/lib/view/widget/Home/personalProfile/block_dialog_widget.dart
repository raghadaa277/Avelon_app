import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class BlockedFollowDialog extends StatelessWidget {
  const BlockedFollowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      content: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedUserBlock01,

            size: 60,

            color: Colors.red,
          ),

          const SizedBox(height: 20),

          const Text(
            "User unavailable",

            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 10),

          const Text(
            "This user has blocked you or is unavailable.",

            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          ElevatedButton(onPressed: Get.back, child: const Text("OK")),
        ],
      ),
    );
  }
}
