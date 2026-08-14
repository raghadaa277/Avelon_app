import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';
import 'package:programmers_network_app/view/screen/Home/post_audience_insights_page.dart';
import 'package:programmers_network_app/view/screen/Home/post_views_overview_page.dart';
import 'package:programmers_network_app/view/screen/Home/views_overview_page.dart';
import 'package:programmers_network_app/view/widget/Home/posts/confirm_delete_widget.dart';
import 'package:programmers_network_app/view/widget/Home/posts/poup_button/post_options_menu_widget.dart';
import 'package:programmers_network_app/controller/Home/posts/archive_post_controller.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;
  final ProfileData profileData;
  const PostHeader({super.key, required this.post, required this.profileData});

  String _timeAgo(String? createdAt) {
    if (createdAt == null) return '';
    final diff = DateTime.now().difference(DateTime.parse(createdAt));
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'article':
        return const Color(0xFF8B5CF6);
      case 'question':
        return const Color(0xFF3B82F6);
      case 'problem':
        return const Color(0xFFEF4444);
      case 'poll':
        return const Color(0xFFF59E0B);
      case 'project':
        return const Color(0xFF10B981);
      default:
        return Colors.grey;
    }
  }

  void _handleMenuAction(String value) {
    switch (value) {
      case 'archive':
        Get.find<ArchivePostController>().archivePost(post.id);
        break;

      case 'edit':
        // Get.find<EditPostController>().editPost(post.id);
        break;

      case "delete":
        Get.dialog(
          ConfirmDeleteDialog(
            onConfirm: () {
              Get.find<ArchivePostController>().forceDeletePost(
                post.id,
                removeFromMyPosts: true,
              );
            },
          ),
          barrierDismissible: false,
        );
        break;
      case 'pin':
        Get.find<EditPostController>().pinnedPost(post.id);
        break;
      case 'post overview':
        Get.to(() => ViewsOverviewPage(postId: post.id));
        break;

      case 'audience':
        Get.to(() => PostAudienceInsightsPage(postId: post.id));
        break;

      case 'post views overview':
        Get.to(() => PostViewsOverviewPage(postId: post.id));
        break;

      case 'save':
        // Get.find<SavePostController>().savePost(post.id);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: const Color(0xFFEFEFEF),
          backgroundImage: profileData.avatarFullUrl != null
              ? NetworkImage(profileData.avatarFullUrl!)
              : null,
          child: profileData.avatarFullUrl == null
              ? const Icon(Icons.person, size: 20, color: Colors.grey)
              : null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileData.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    _timeAgo(post.createdAt),
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _typeColor(post.type).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      post.type[0].toUpperCase() + post.type.substring(1),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _typeColor(post.type),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        PostOptionsMenu(isPinned: post.isPinned, onSelected: _handleMenuAction),
      ],
    );
  }
}
