import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/mutualFollowers/get_mutual_followers_model.dart';
import 'package:programmers_network_app/view/screen/Home/personalPage/other_user_profile_page.dart';

class MutualCard extends StatelessWidget {
  final MutualFollowerUser user;

  const MutualCard({super.key, required this.user});

  void openProfile(BuildContext context) {
    Get.to(() => OtherUserProfilePage(targetUserId: user.user.userId));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => openProfile(context),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: user.user.avatarFullUrl != null
                ? NetworkImage(user.user.avatarFullUrl!)
                : null,
          ),
          title: Text(
            user.fullName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text("@${user.user.userName}"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        ),
      ),
    );
  }
}
