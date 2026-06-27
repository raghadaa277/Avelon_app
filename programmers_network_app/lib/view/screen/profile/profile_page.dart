import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/const/api_Constants.dart';
import '../../../core/services/profile_services.dart';
import '../../../core/storage/api_client.dart';
import '../../../cubit/profile/profile_cubit.dart';
import '../../../cubit/profile/profile_state.dart';
import '../../../data/models/Profile/profile_model.dart';
import 'EditPhotoScreen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(service: ProfileServices(ApiClient(baseUrl: ApiConstants.baseurl)))..fetchProfile(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1FDE1),
        appBar: _buildAppBar(context),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator(color: Color(0xffB8FF1A)));
            } else if (state is ProfileError) {
              return Center(child: Text(state.errorMessage));
            } else if (state is ProfileLoaded) {
              final profileData = state.profileModel.data;


              Widget activeContent;
              if (state.activeTabIndex == 0) {
                activeContent = PostsTabContent(isActive: true);
              } else if (state.activeTabIndex == 1) {
                activeContent = AboutTabContent(data: profileData);
              } else {
                activeContent = SkillsTabContent(isActive: true);
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    UserHeaderCard(data: profileData),
                    const SizedBox(height: 16),
                    ActionButtonsRow(profileData: profileData),
                    const SizedBox(height: 20),
                    _buildTabBar(context, state.activeTabIndex),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: activeContent,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: const EdgeInsets.only(left: 6),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 14),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      title: const Text(
        'A V E L O N',
        style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 2.5),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.black54, size: 20),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildTabBar(BuildContext context, int activeIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildTabItem(
              icon: Icons.sticky_note_2_outlined,
              label: "Posts",
              isActive: activeIndex == 0,
              showAddIcon: activeIndex == 0,
              onTap: () => context.read<ProfileCubit>().changeTab(0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildTabItem(
              icon: activeIndex == 1 ? Icons.person : Icons.person_outline,
              label: "About",
              isActive: activeIndex == 1,
              showAddIcon: false,
              onTap: () => context.read<ProfileCubit>().changeTab(1),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildTabItem(
              icon: Icons.bolt,
              label: "Skills",
              isActive: activeIndex == 2,
              showAddIcon: false,
              onTap: () => context.read<ProfileCubit>().changeTab(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required bool showAddIcon,
    required VoidCallback onTap,
  }) {
    final Color activeColor = const Color(0xffB8FF1A);
    final Color inactiveIconColor = Colors.grey.shade400;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showAddIcon) ...[
                  Icon(Icons.add, size: 14, color: activeColor),
                  const SizedBox(width: 2),
                ],
                Icon(
                  icon,
                  size: 16,
                  color: isActive ? activeColor : inactiveIconColor,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive ? Colors.black : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            if (isActive) ...[
              const SizedBox(height: 4),
              Container(
                width: 16,
                height: 2,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
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
            {'label': 'Backend Developer at Avelon', 'icon': Icons.laptop_chromebook},
          ],
        ),
        const SizedBox(height: 16),


        _buildAboutCard(
          title: "Experience",
          icon: Icons.business_center_outlined,
          items: [
            {'label': '${data.experienceYears} Years Experience', 'icon': Icons.trending_up},
          ],
        ),
        const SizedBox(height: 16),


        _buildAboutCard(
          title: "Location",
          icon: Icons.location_on_outlined,
          items: [
            {'label': '${data.city}, ${data.country}', 'icon': Icons.map_outlined},
          ],
        ),
        const SizedBox(height: 16),


        _buildAboutCard(
          title: "Education",
          icon: Icons.school_outlined,
          items: [
            {'label': data.educationStatus, 'icon': Icons.check_circle_outline},
            {'label': data.university, 'icon': Icons.account_balance_outlined},
            {'label': data.major ?? "Software Engineering", 'icon': Icons.layers_outlined},
            {'label': data.studyYear == "fourth_year" ? "Year 4" : data.studyYear, 'icon': Icons.timeline},
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
                  const SizedBox(width: 10),
                  Text("Connect", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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


  Widget _buildAboutCard({required String title, required IconData icon, required List<Map<String, dynamic>> items}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 24, color: Color(0xFFF1FDE1)),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(item['icon'] as IconData, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    (item['label'] as String).toUpperCase(),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }


  Widget _buildLinkTile({required String label,
    required BuildContext context,
    required IconData icon,
    String? url}) {
    final bool hasUrl = url != null && url.isNotEmpty;
    return GestureDetector(
        onTap: () => _launchURL(context, url),
        behavior: HitTestBehavior.opaque,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(icon, size: 18, color: Colors.black87),
                const SizedBox(width: 12),
                Text(label, style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
                const Spacer(),
                Text(
                  url != null ? "View Profile" : "Not Provided",
                  style: TextStyle(
                    fontSize: 12,
                    color: url != null ? Colors.grey : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                    Icons.arrow_forward_ios, size: 12, color: Colors.grey),
              ],
            ),),);
  }}

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
            const Icon(Icons.sticky_note_2_outlined, size: 48, color: Color(0xffB8FF1A)),
            const SizedBox(height: 16),
            Text('No posts yet', style: TextStyle(color: Colors.grey[400], fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class ActionButtonsRow extends StatelessWidget {
  final ProfileData profileData;
  const ActionButtonsRow({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => BlocProvider.value(
                  value: context.read<ProfileCubit>(),
                  child: EditPhotoScreen(profileData: profileData),
                ),
              ),
            ).then((_) {

              if (context.mounted) {
                context.read<ProfileCubit>().fetchProfile();
              }
            });
          },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(color: const Color(0xffB8FF1A), borderRadius: BorderRadius.circular(14)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_note_rounded, size: 16),
                  SizedBox(width: 6),
                  Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                ],
              ),
            ),
          ),),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade300)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.ios_share, size: 16),
                  SizedBox(width: 6),
                  Text("Share", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
          ), ],
      ),
    );
  }
}

class UserHeaderCard extends StatelessWidget {
  final ProfileData data;
  const UserHeaderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Stack(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: const Color(0xFFEFEFEF),
                    backgroundImage: data.avatarFullUrl != null ? NetworkImage(data.avatarFullUrl!) : null,
                    child: data.avatarFullUrl == null
                        ? const Icon(Icons.person, size: 40, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(1.5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Color(0xffB8FF1A),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),


              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          data.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 6),

                      ],
                    ),
                    const SizedBox(height: 2),


                    Text(
                      '@${data.username}',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),

                    // 3. التخصص
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xffB8FF1A).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        data.specialization,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 8),


                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.grey[400], size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${data.city}, ${data.country}',
                          style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // 5. الـ Bio
                    Text(
                      data.bio,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),


          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("128", "Posts"),
                _buildVerticalDivider(),
                _buildStatItem("2.4K", "Followers"),
                _buildVerticalDivider(),
                _buildStatItem("315", "Following"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey.shade200,
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14, color: Colors.black),
                label: const Text("Add Skill", style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffB8FF1A),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummySkills.length,
            separatorBuilder: (context, index) => const Divider(height: 20, color: Color(0xFFF1FDE1)),
            itemBuilder: (context, index) {
              final skill = dummySkills[index];
              return Row(
                children: [
                  const Icon(Icons.blur_circular, size: 18, color: Colors.grey),
                  const SizedBox(width: 12),
                  Text(
                    skill['name']!,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1FDE1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      skill['level']!,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
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