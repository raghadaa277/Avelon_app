import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/models/Profile/profile_model.dart';

class PostsTabContent extends StatelessWidget {
  final bool isActive;
  const PostsTabContent({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            const Icon(
              Icons.sticky_note_2_outlined,
              size: 48,
              color: Color(0xffB8FF1A),
            ),
            const SizedBox(height: 16),
            Text(
              'No posts yet',
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutTabContent extends StatelessWidget {
  final ProfileData data;
  const AboutTabContent({super.key, required this.data});

  Future<void> _launchURL(BuildContext context, String? urlString) async {
    if (urlString == null || urlString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Link not available")),
      );
      return;
    }
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $urlString';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open link: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAboutCard(
          title: "Developer Information",
          icon: Icons.info_outline,
          items: [
            {
              'label': 'Backend Developer at Avelon',
              'icon': Icons.laptop_chromebook,
            },
          ],
        ),
        const SizedBox(height: 16),
        _buildAboutCard(
          title: "Experience",
          icon: Icons.business_center_outlined,
          items: [
            {
              'label': '${data.experienceYears} Years Experience',
              'icon': Icons.trending_up,
            },
          ],
        ),
        const SizedBox(height: 16),
        _buildAboutCard(
          title: "Location",
          icon: Icons.location_on_outlined,
          items: [
            {
              'label': '${data.city}, ${data.country}',
              'icon': Icons.map_outlined,
            },
          ],
        ),
        const SizedBox(height: 16),
        _buildAboutCard(
          title: "Education",
          icon: Icons.school_outlined,
          items: [
            {'label': data.educationStatus, 'icon': Icons.check_circle_outline},
            {'label': data.university, 'icon': Icons.account_balance_outlined},
            {
              'label': data.major ?? "Software Engineering",
              'icon': Icons.layers_outlined,
            },
            {
              'label': data.studyYear == "fourth_year" ? "Year 4" : data.studyYear,
              'icon': Icons.timeline,
            },
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.link_rounded, size: 18, color: Colors.black87),
                  SizedBox(width: 10),
                  Text(
                    "Connect",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(height: 24, color: Color(0xFFF1FDE1)),
              _buildLinkTile(
                context: context,
                label: "GitHub",
                icon: Icons.code,
                url: data.githubUrl,
              ),
              const Divider(height: 20, color: Color(0xFFF1FDE1)),
              _buildLinkTile(
                context: context,
                label: "LinkedIn",
                icon: Icons.account_circle_outlined,
                url: data.linkedinUrl,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutCard({
    required String title,
    required IconData icon,
    required List<Map<String, dynamic>> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 24, color: Color(0xFFF1FDE1)),
          ...items.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      (item['label'] as String).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile({
    required String label,
    required BuildContext context,
    required IconData icon,
    String? url,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(context, url),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              url != null ? "View Profile" : "Not Provided",
              style: TextStyle(
                fontSize: 12,
                color: url != null ? Colors.grey : Colors.grey.shade400,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class SkillsTabContent extends StatelessWidget {
  final bool isActive;
  const SkillsTabContent({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dummySkills = [
      {'name': 'Laravel', 'level': 'Expert'},
      {'name': 'PHP', 'level': 'Expert'},
      {'name': 'JavaScript', 'level': 'Advanced'},
      {'name': 'Vue.js', 'level': 'Advanced'},
      {'name': 'MySQL', 'level': 'Advanced'},
      {'name': 'Git', 'level': 'Intermediate'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Skills",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14, color: Colors.black),
                label: const Text(
                  "Add Skill",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffB8FF1A),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummySkills.length,
            separatorBuilder: (context, index) =>
            const Divider(height: 20, color: Color(0xFFF1FDE1)),
            itemBuilder: (context, index) {
              final skill = dummySkills[index];
              return Row(
                children: [
                  const Icon(Icons.blur_circular, size: 18, color: Colors.grey),
                  const SizedBox(width: 12),
                  Text(
                    skill['name']!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1FDE1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      skill['level']!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.more_horiz, size: 16, color: Colors.grey),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}