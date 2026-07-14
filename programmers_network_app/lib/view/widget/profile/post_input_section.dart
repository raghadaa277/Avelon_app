import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';

class PostInputSection extends StatelessWidget {
  final ProfileData profileData;

  const PostInputSection({super.key, required this.profileData});

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
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFEFEFEF),
            backgroundImage:
                (profileData.avatarFullUrl != null &&
                    profileData.avatarFullUrl!.isNotEmpty)
                ? NetworkImage(profileData.avatarFullUrl!)
                : null,
            child:
                (profileData.avatarFullUrl == null ||
                    profileData.avatarFullUrl!.isEmpty)
                ? const Icon(Icons.person, size: 18, color: Colors.grey)
                : null,
          ),

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
