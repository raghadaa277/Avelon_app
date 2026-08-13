import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/post_color.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/info_pill.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_style.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostHeaderWidget extends StatelessWidget {
  final Post post;
  final VoidCallback? onUserTap;
  final VoidCallback? onWhySeeing;

  const PostHeaderWidget({
    super.key,
    required this.post,
    this.onUserTap,
    this.onWhySeeing,
  });

  @override
  Widget build(BuildContext context) {
    final PostUser author = post.user;
    final type = postTypeInfo(post.type);
    final visibility = postVisibilityInfo(post.visibility);
    final followStatus = followStatusInfo(post.followStatus);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onUserTap,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: author.userProfile?.avatarFullUrl != null
                          ? NetworkImage(author.userProfile!.avatarFullUrl!)
                          : null,
                      child: author.userProfile?.avatarFullUrl == null
                          ? Text(
                              author.fullName.isNotEmpty
                                  ? author.fullName[0]
                                  : '?',
                            )
                          : null,
                    ),

                    const SizedBox(width: 10),

                    Flexible(
                      child: Text(
                        author.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(width: 8),

                    InfoPill(
                      icon: followStatus.icon,
                      color: followStatus.color,
                      label: followStatus.label,
                      iconOnly: false,
                    ),
                  ],
                ),
              ),
            ),

            if (onWhySeeing != null)
              IconButton(
                onPressed: onWhySeeing,
                tooltip: "Why you're seeing this",
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.all(6),
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedInformationCircle,
                  color: Colors.grey.shade700,
                  size: 21,
                ),
              ),

            // More
            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedMoreHorizontal,
                color: Colors.grey.shade700,
                size: 21,
              ),
              onPressed: () {},
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            Text(
              post.publishedAt != null ? timeago.format(post.publishedAt!) : '',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),

            const SizedBox(width: 5),

            InfoPill(
              icon: visibility.icon,
              color: visibility.color,
              label: visibility.label,
              iconOnly: true,
            ),

            const SizedBox(width: 5),

            InfoPill(
              icon: type.icon,
              color: type.color,
              label: type.label,
              iconOnly: true,
            ),

            const SizedBox(width: 8),

            if (post.isEdited) ...[
              const SizedBox(width: 6),
              Tooltip(
                message: 'Edited',
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedEdit02,
                  color: Colors.grey.shade600,
                  size: 14,
                ),
              ),
            ],

            if (post.isPinned) ...[
              const SizedBox(width: 8),
              InfoPill(
                icon: HugeIcons.strokeRoundedPin,
                color: PostColors.pinned,
                label: 'Pinned',
                filled: true,
                iconOnly: true,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
