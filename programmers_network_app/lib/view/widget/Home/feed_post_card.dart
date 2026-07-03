import 'package:flutter/material.dart';

class FeedPostCard extends StatelessWidget {
  final String name;
  final String handle;
  final String time;
  final String content;
  final bool isCodePost;
  final String likes;
  final String comments;
  final String reposts;

  const FeedPostCard({
    super.key,
    required this.name,
    required this.handle,
    required this.time,
    required this.content,
    required this.isCodePost,
    required this.likes,
    required this.comments,
    required this.reposts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(''),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(width: 4),
                      const Icon(Icons.check_circle, color: Color(0xffB8FF1A), size: 14),
                    ],
                  ),
                  Text('$handle • $time', style: TextStyle(color: Colors.grey[400], fontSize: 11)),
                ],
              ),
              const Spacer(),
              Icon(Icons.more_horiz, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: TextStyle(height: 1.4, color: Colors.grey[800], fontSize: 14)),
          const SizedBox(height: 12),
          if (isCodePost)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1117),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('1   <?php', style: TextStyle(color: Colors.grey, fontSize: 10, fontFamily: 'monospace')),
                          Text("2   Route::middleware(['auth:sanctum'])", style: TextStyle(color: Color(0xffB8FF1A), fontSize: 10, fontFamily: 'monospace')),
                          Text("3   ->prefix('api')", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
                          Text("4   ->group(function () {", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
                          Text("5      Route::apiResource('posts',", style: TextStyle(color: Color(0xffB8FF1A), fontSize: 10, fontFamily: 'monospace')),
                          Text("6      PostController::class);", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
                          Text("16   });", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Performance', style: TextStyle(color: Colors.grey, fontSize: 10)),
                          Text('+3x', style: TextStyle(color: Color(0xffB8FF1A), fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 16),
                          Text('Requests', style: TextStyle(color: Colors.grey, fontSize: 10)),
                          Text('24.8K', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=2070&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStat(Icons.favorite_border, likes, Colors.grey[600]!),
              const SizedBox(width: 24),
              _buildStat(Icons.chat_bubble_outline, comments, Colors.grey[600]!),
              const SizedBox(width: 24),
              _buildStat(Icons.repeat, reposts, Colors.grey[600]!),
              const Spacer(),
              Icon(Icons.bookmark_border, color: Colors.grey[600]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String count, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(count, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      ],
    );
  }
}