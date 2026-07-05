import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';
import 'package:programmers_network_app/view/widget/Home/posts/getPost/post_actions_widget.dart';
import 'package:programmers_network_app/view/widget/Home/posts/getPost/post_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/posts/getPost/post_media_slider_widget.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final ProfileData profileData;
  const PostCard({super.key, required this.post, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post, profileData: profileData),
          const SizedBox(height: 12),

          if (post.title != null) ...[
            Text(
              post.title!,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const SizedBox(height: 4),
          ],

          if (post.content != null) ...[
            Text(
              post.content!,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 10),
          ],

          if (post.postMedia.isNotEmpty) ...[
            PostMediaSlider(media: post.postMedia),
            const SizedBox(height: 10),
          ],

          if (post.poll != null) ...[
            _PollWidget(poll: post.poll!),
            const SizedBox(height: 10),
          ],

          const Divider(height: 20),
          PostActions(post: post),
        ],
      ),
    );
  }
}

class _PollWidget extends StatelessWidget {
  final PollModel poll;
  const _PollWidget({required this.poll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          poll.question,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        const SizedBox(height: 10),
        ...poll.pollOptions.map((option) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffB8FF1A)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              option.option,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          );
        }),
      ],
    );
  }
}
