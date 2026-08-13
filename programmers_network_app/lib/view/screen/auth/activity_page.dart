import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/post_color.dart';
import 'package:programmers_network_app/view/screen/Home/disliked_post_page.dart';
import 'package:programmers_network_app/view/widget/Home/activity_categore_card_widget.dart';
import 'package:programmers_network_app/view/screen/Home/commented_post_page_widget.dart';
import 'package:programmers_network_app/view/screen/Home/liked_post_page.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Activities',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          children: [
            ActivityCategoryCard(
              title: 'Commented Posts',
              subtitle: 'Posts you have commented on',
              icon: HugeIcons.strokeRoundedMessage01,
              color: const Color(0xFF14B8A6),
              onTap: () {
                Get.to(() => CommentedPostsPage());
              },
            ),

            SizedBox(height: 5),
            ActivityCategoryCard(
              title: 'Liked Posts',
              subtitle: 'Posts you have liked on',
              icon: HugeIcons.strokeRoundedMessage01,
              color: PostColors.like,
              onTap: () {
                Get.to(() => LikedPostsPage());
              },
            ),
            SizedBox(height: 5),
            ActivityCategoryCard(
              title: 'DisLiked Posts',
              subtitle: 'Posts you have disliked on',
              icon: HugeIcons.strokeRoundedMessage01,
              color: PostColors.dislike,
              onTap: () {
                Get.to(() => DisLikedPostsPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
