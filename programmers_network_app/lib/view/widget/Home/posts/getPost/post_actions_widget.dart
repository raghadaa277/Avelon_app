import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';

class PostActions extends StatelessWidget {
  final PostModel post;
  const PostActions({super.key, required this.post});

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: Icons.thumb_up_outlined,
          count: _formatCount(post.likesCount),
          onTap: () {},
        ),
        const SizedBox(width: 16),
        _ActionButton(
          icon: Icons.thumb_down_outlined,
          count: '0',
          onTap: () {},
        ),
        const SizedBox(width: 16),
        _ActionButton(
          icon: Icons.chat_bubble_outline,
          count: _formatCount(post.commentsCount),
          onTap: () {},
        ),
        const SizedBox(width: 16),
        if (!post.hideViews)
          _ActionButton(
            icon: Icons.remove_red_eye_outlined,
            count: _formatCount(post.viewsCount),
            onTap: () {},
          ),
        const Spacer(),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 4),
          Text(count, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
