import 'package:flutter/material.dart';

import '../profile/profile_page.dart';

class HomePage extends StatelessWidget {
  final String profileCompletion;
  const HomePage({super.key, required this.profileCompletion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              ProfileCompletionCard(completionText: profileCompletion),
              const SizedBox(height: 24),
              const StoriesSection(),
              const SizedBox(height: 24),
              const PostInputSection(),
              const SizedBox(height: 24),
              const FeedPostCard(
                name: 'Ahmed Saadi',
                handle: '@ahmad_dev',
                time: '2h ago',
                content:
                    'Finished building my new Laravel API architecture 🚀\nPerformance is 3x better than before.',
                isCodePost: true,
                likes: '54',
                comments: '12',
                reposts: '5',
              ),
              const SizedBox(height: 16),
              const FeedPostCard(
                name: 'Ahmed Saadi',
                handle: '@ahmad_dev',
                time: 'Yesterday',
                content:
                    'Working on a new SaaS idea.\nExcited to build something impactful! 💡',
                isCodePost: false,
                likes: '78',
                comments: '21',
                reposts: '7',
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xff8CEE1A), Color(0xffC6FF1A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: const Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'sans-serif',
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'AVELON',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Stack(
              children: [
                const Icon(Icons.notifications_none, size: 23),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xffB8FF1A),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=me'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class AvelonLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    paint.shader = const LinearGradient(
      colors: [Color(0xff76DE1A), Color(0xffB8FF1A)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    path.moveTo(size.width * 0.15, size.height);
    path.lineTo(size.width * 0.65, size.height * 0.05);
    path.lineTo(size.width * 0.95, size.height * 0.65);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProfileCompletionCard extends StatelessWidget {
  final String completionText;
  const ProfileCompletionCard({super.key, required this.completionText});

  @override
  Widget build(BuildContext context) {
    final cleanNumber = completionText.replaceAll('%', '').trim();
    final double progressValue = (double.tryParse(cleanNumber) ?? 0.0) / 100.0;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.015),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 2.5,
                      backgroundColor: Colors.grey[100],

                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xffB8FF1A),
                      ),
                    ),
                  ),
                  Text(
                    completionText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Complete your profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Add photo, bio and links to\nbuild your identity',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 10,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),

              GestureDetector(
                onTap: () {
                  print("BUTTON CLICKED");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        print("BUILDING PROFILE PAGE");
                        return const ProfilePage();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffB8FF1A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Complete',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 14, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {
        'name': 'Your story',
        'img': 'https://i.pravatar.cc/150?u=1',
        'isMe': true,
      },
      {
        'name': 'Sarah Dev',
        'img': 'https://i.pravatar.cc/150?u=2',
        'isMe': false,
      },
      {
        'name': 'Omar Code',
        'img': 'https://i.pravatar.cc/150?u=3',
        'isMe': false,
      },
      {
        'name': 'Lina Tech',
        'img': 'https://i.pravatar.cc/150?u=4',
        'isMe': false,
      },
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
                            backgroundImage: NetworkImage(
                              story['img'] as String,
                            ),
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
                              child: const Icon(
                                Icons.add,
                                size: 12,
                                color: Colors.black,
                              ),
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
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
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
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=me'),
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
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?u=ahmed',
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xffB8FF1A),
                        size: 14,
                      ),
                    ],
                  ),
                  Text(
                    '$handle • $time',
                    style: TextStyle(color: Colors.grey[400], fontSize: 11),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.more_horiz, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              height: 1.4,
              color: Colors.grey[800],
              fontSize: 14,
            ),
          ),
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
                          Text(
                            '1   <?php',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            "2   Route::middleware(['auth:sanctum'])",
                            style: TextStyle(
                              color: Color(0xffB8FF1A),
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            "3   ->prefix('api')",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            "4   ->group(function () {",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            "5      Route::apiResource('posts',",
                            style: TextStyle(
                              color: Color(0xffB8FF1A),
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            "6      PostController::class);",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            "16   });",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
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
                          Text(
                            'Performance',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          Text(
                            '+3x',
                            style: TextStyle(
                              color: Color(0xffB8FF1A),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Requests',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          Text(
                            '24.8K',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
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
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=2070&auto=format&fit=crop',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStat(Icons.favorite_border, likes, Colors.grey[600]!),
              const SizedBox(width: 24),
              _buildStat(
                Icons.chat_bubble_outline,
                comments,
                Colors.grey[600]!,
              ),
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

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildNavItem(
              context,
              Icons.home_outlined,
              'Home',
              true,
              onTap: () {},
            ),
          ),
          Expanded(
            child: _buildNavItem(
              context,
              Icons.search,
              'Explore',
              false,
              onTap: () {},
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xffB8FF1A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.add, color: Colors.black, size: 24),
              ),
            ),
          ),
          Expanded(
            child: _buildNavItem(
              context,
              Icons.notifications_none,
              'Notifications',
              false,
              onTap: () {},
            ),
          ),

          // 💡 هنا قمنا بربط أيقونة البروفايل بالانتقال النقي للبلوك
          Expanded(
            child: _buildNavItem(
              context,
              Icons.person_outline,
              'Profile',
              false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // أضفنا الـ context والـ onTap لتفعيل الضغط والتنقل
  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // يضمن استجابة المنطقة بالكامل لللمس
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xffB8FF1A) : Colors.grey[400],
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey[400],
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
