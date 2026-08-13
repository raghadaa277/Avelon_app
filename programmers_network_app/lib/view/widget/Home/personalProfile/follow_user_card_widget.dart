import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:programmers_network_app/data/models/Home/personalPage/follower/get_follows_model.dart';
import 'package:programmers_network_app/view/screen/Home/personalPage/other_user_profile_page.dart';

// import 'package:programmers_network_app/view/widget/Home/personalProfile/block_dialog_widget.dart';

class FollowUserCard extends StatelessWidget {
  final FollowerUser user;

  const FollowUserCard({super.key, required this.user});

  void openProfile(BuildContext context) {
    // if (user.userProfile.isBlockedBy == true) {
    //   Get.dialog(const BlockedFollowDialog());
    //   return;
    // }

    Get.to(() => OtherUserProfilePage(targetUserId: user.userProfile.userId));
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

            backgroundImage: user.userProfile.avatarFullUrl != null
                ? NetworkImage(user.userProfile.avatarFullUrl!)
                : null,
          ),

          title: Text(
            user.fullName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),

          subtitle: Text("@${user.userProfile.username}"),

          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        ),
      ),
    );
  }
}
