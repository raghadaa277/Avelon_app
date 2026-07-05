import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';

class PostInputSection extends StatelessWidget {
  const PostInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 16, backgroundImage: NetworkImage('')),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoute.CreatePost);
              },
              child: Text(
                "What's on your mind?",
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            ),
          ),
          HugeIcon(
            icon: HugeIcons.strokeRoundedImageAdd01,
            color: Colors.grey.shade400,
            size: 22,
          ),
        ],
      ),
    );
  }
}
