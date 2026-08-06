import 'package:flutter/material.dart';

class PostInputSection extends StatelessWidget {
  final String? userAvatarUrl;
  final VoidCallback? onTap;

  const PostInputSection({
    super.key,
    this.userAvatarUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[200],
              backgroundImage: (userAvatarUrl != null && userAvatarUrl!.isNotEmpty)
                  ? NetworkImage(userAvatarUrl!)
                  : null,
              child: (userAvatarUrl == null || userAvatarUrl!.isEmpty)
                  ? const Icon(Icons.person, color: Colors.grey, size: 20)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "What's on your mind?",
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            ),
            Icon(Icons.image_outlined, color: Colors.grey[400], size: 22),
          ],
        ),
      ),
    );
  }
}