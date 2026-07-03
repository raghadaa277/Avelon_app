import 'package:flutter/material.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {'name': 'Your story', 'img': 'https://i.pravatar.cc/150?u=1', 'isMe': true},
      {'name': 'Sarah Dev', 'img': 'https://i.pravatar.cc/150?u=2', 'isMe': false},
      {'name': 'Omar Code', 'img': 'https://i.pravatar.cc/150?u=3', 'isMe': false},
      {'name': 'Lina Tech', 'img': 'https://i.pravatar.cc/150?u=4', 'isMe': false},
      {'name': 'Hassan', 'img': 'https://i.pravatar.cc/150?u=5', 'isMe': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Stories',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Spacer(),
            Text(
              'View all >',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xffB8FF1A),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(story['img'] as String),
                          ),
                        ),
                        if (story['isMe'] as bool)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xffB8FF1A),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add, size: 12, color: Colors.black),
                            ),
                          )
                        else
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: const Color(0xffB8FF1A),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      story['name'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}