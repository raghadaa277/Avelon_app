import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';

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
        const Icon(Icons.more_horiz, color: Colors.grey),
      ],
    );
  }
}
