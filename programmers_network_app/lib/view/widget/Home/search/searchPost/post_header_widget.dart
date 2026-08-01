import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/post_color.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/info_pill.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_style.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostHeaderWidget extends StatelessWidget {
  final Post post;

  const PostHeaderWidget({super.key, required this.post});

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
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: author.userProfile?.avatarFullUrl != null
                  ? NetworkImage(author.userProfile!.avatarFullUrl!)
                  : null,
              child: author.userProfile?.avatarFullUrl == null
                  ? Text(author.fullName.isNotEmpty ? author.fullName[0] : '?')
                  : null,
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Row(
                children: [
                  Text(
                    author.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(width: 5),
                  InfoPill(
                    icon: followStatus.icon,
                    color: followStatus.color,
                    label: followStatus.label,
                    iconOnly: false,
                  ),
                ],
              ),
            ),

            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedMoreHorizontal,
                color: Colors.grey.shade700,
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
            const SizedBox(width: 5),
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
