import 'package:flutter/material.dart';

class PostInputSection extends StatelessWidget {
  const PostInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(''),
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
    );
  }
}