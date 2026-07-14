import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/archive_post_controller.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_archived_posts_model.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';
import 'package:programmers_network_app/view/widget/Home/posts/confirm_delete_widget.dart';
import 'package:programmers_network_app/view/widget/Home/posts/poup_button/archive_options_menu_widget.dart';

class ArchivedPostCard extends StatelessWidget {
  final DataArchivedPost post;
  final ProfileData profileData;

  const ArchivedPostCard({
    super.key,
    required this.post,
    required this.profileData,
  });

  String _timeAgo(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt);
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

  void _handleMenuAction(String value, int postNumber) {
    switch (value) {
      case "restore":
        Get.find<ArchivePostController>().restorePost(postNumber);
        break;

      case "delete":
        Get.dialog(
          ConfirmDeleteDialog(
            onConfirm: () {
              Get.find<ArchivePostController>().forceDeletePost(
                postNumber,
                removeFromArchive: true,
              );
            },
          ),
          barrierDismissible: false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F1F1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFEFEFEF),
                backgroundImage:
                    (profileData.avatarFullUrl != null &&
                        profileData.avatarFullUrl!.isNotEmpty)
                    ? NetworkImage(profileData.avatarFullUrl!)
                    : null,
                child:
                    (profileData.avatarFullUrl == null ||
                        profileData.avatarFullUrl!.isEmpty)
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
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
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

              // // Archived Badge
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   decoration: BoxDecoration(
              //     color: Colors.grey[100],
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: const Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       HugeIcon(
              //         icon: HugeIcons.strokeRoundedArchive02,
              //         size: 14,
              //         color: Colors.grey,
              //       ),
              //       SizedBox(width: 4),
              //       Text(
              //         'Archived',
              //         style: TextStyle(fontSize: 11, color: Colors.grey),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(width: 4),

              ArchiveOptionsMenuWidget(
                onSelected: (value) {
                  _handleMenuAction(value, post.id);
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (post.title != null && post.title!.isNotEmpty) ...[
            Text(
              post.title!,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            const SizedBox(height: 4),
          ],
          if (post.content != null && post.content!.isNotEmpty)
            Text(
              post.content!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
            ),

          const SizedBox(height: 12),

          Row(
            children: [
              Icon(
                Icons.thumb_up_alt_outlined,
                size: 16,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text('${post.likesCount}', style: _statStyle()),
              const SizedBox(width: 16),
              Icon(
                Icons.chat_bubble_outline,
                size: 16,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text('${post.commentsCount}', style: _statStyle()),
              const SizedBox(width: 16),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 16,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text('${post.viewsCount}', style: _statStyle()),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _statStyle() => TextStyle(fontSize: 12, color: Colors.grey[600]);
}
