import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';

import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_engagment_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_header_widget.dart';

import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_media.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_viewed.dart';

class PostCardWidget extends StatelessWidget {
  final Post post;
  final List<PostMedia> media;

  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final VoidCallback? onTap;
  final VoidCallback? onUserTap;

  // Optional: only wired up on the home feed for now, so it's nullable
  // rather than required — other screens using this card simply won't
  // pass it and the icon/button won't render (see PostHeaderWidget).
  final VoidCallback? onWhySeeing;

  const PostCardWidget({
    super.key,
    required this.post,
    required this.media,
    this.onLike,
    this.onDislike,
    this.onComment,
    this.onShare,
    this.onSave,
    this.onTap,
    this.onUserTap,
    this.onWhySeeing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            // ignore: deprecated_member_use
            BoxShadow(
              color: Colors.black,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeaderWidget(
              post: post,
              onUserTap: onUserTap,
              onWhySeeing: onWhySeeing,
            ),
            const SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  post.content,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),

                if (post.postMedia.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  PostMediaSliderSearch(media: media, postId: post.id),
                ],
              ],
            ),

            const SizedBox(height: 8),
            PostViewedBadge(post: post),
            const SizedBox(height: 8),

            const Divider(height: 1),
            const SizedBox(height: 6),

            PostEngagementBar(
              post: post,
              onLike: onLike,
              onDislike: onDislike,
              onComment: onComment,

              onSave: onSave,
            ),
          ],
        ),
      ),
    );
  }
}
