import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/archive_post_controller.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';
import 'package:programmers_network_app/view/widget/Home/posts/archive_post_card_widget.dart';

class ArchivedPostsList extends StatelessWidget {
  final ProfileData profileData;

  const ArchivedPostsList({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    final ArchivePostController ctrl = Get.find<ArchivePostController>();

    return Obx(() {
      if (ctrl.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xffB8FF1A)),
        );
      }

      if (ctrl.archive.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              children: [
                const Icon(
                  Icons.archive_outlined,
                  size: 48,
                  color: Color(0xffB8FF1A),
                ),
                const SizedBox(height: 16),
                Text(
                  'No archived posts yet',
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ctrl.archive.length,
        itemBuilder: (context, index) {
          return ArchivedPostCard(
            post: ctrl.archive[index],
            profileData: profileData,
          );
        },
      );
    });
  }
}
