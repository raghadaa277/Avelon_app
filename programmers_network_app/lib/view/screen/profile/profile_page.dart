import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/auth/logout_controller.dart';
import 'package:programmers_network_app/cubit/profile/Follow_cubit.dart';
import 'package:programmers_network_app/view/screen/profile/FollowScreen.dart';
import 'package:programmers_network_app/view/screen/profile/PrivacySettingsPage.dart';
import 'package:programmers_network_app/view/widget/profile/slider_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../cubit/PrivacySettings/privacy_settings_cubit.dart';
import '../../../cubit/profile/close_friends_cubit.dart';
import '../../../cubit/profile/muted_users_cubit.dart';
import '../../../data/services/profile/FollowService.dart';
import '../../../data/services/profile/MutedUsersService.dart';
import '../../../data/services/profile/close_friends_service.dart';
import '../../../data/services/profile/profile_services.dart';
import '../../../cubit/profile/profile_cubit.dart';
import '../../../cubit/profile/profile_state.dart';
import '../../../data/models/Profile/profile_model.dart';
import '../../widget/profile/ActionButtonsRow_widget.dart';
import '../../widget/profile/PostInputSection.dart';
import '../../widget/profile/PostsTabContent_widget.dart';
import '../../widget/profile/ProfileAppBar.dart';
import '../../widget/profile/UserHeaderCard_widget.dart';

import 'EditPhotoScreen.dart';
import 'close_friends_screen.dart';
import 'muted_users_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final LogoutController logoutController = Get.put(LogoutController());

  void _showLogoutDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Logout",
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, _, __) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.logout_rounded,
                    size: 50,
                    color: Color(0xffB8FF1A),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Are you sure you want to log out?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            logoutController.logout();
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            logoutController.logout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffB8FF1A),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, _, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(ProfileServices())..fetchProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Scaffold(
              backgroundColor: const Color(0xFFF1FDE1),
              appBar: const ProfileAppBar(),
              body: const Center(
                child: CircularProgressIndicator(color: Color(0xffB8FF1A)),
              ),
            );
          } else if (state is ProfileError) {
            return Scaffold(
              backgroundColor: const Color(0xFFF1FDE1),
              appBar: const ProfileAppBar(),
              body: Center(child: Text(state.errorMessage)),
            );
          } else if (state is ProfileLoaded) {
            final profileData = state.profileModel.data;
            final completionPercentage =
                state.profileModel.profileCompletion ?? "0%";
            Widget activeContent;
            if (state.activeTabIndex == 0) {
              activeContent = PostsTabContent(isActive: true);
            } else if (state.activeTabIndex == 1) {
              activeContent = AboutTabContent(data: profileData);
            } else {
              activeContent = SkillsTabContent(isActive: true);
            }
            return AvelonHomeShell(
              menu: ProfileSideMenu(
                data: profileData,
                onSettings: () {
                  AvelonHomeShell.of(context)?.closeMenu();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider<PrivacySettingsCubit>(
                        create: (context) =>
                            PrivacySettingsCubit(services: ProfileServices()),
                        child: const PrivacySettingsPage(),
                      ),
                    ),
                  );
                },
                onFavoritePeople: () {
                  AvelonHomeShell.of(context)?.closeMenu();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider<CloseFriendsCubit>(
                        create: (context) =>
                        CloseFriendsCubit(CloseFriendsService())
                          ..fetchCloseFriends(),
                        child: const CloseFriendsScreen(),
                      ),
                    ),
                  );
                },
                onFollowingTracking: () {
                  AvelonHomeShell.of(context)?.closeMenu();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FollowScreen(userId: profileData.id),
                    ),
                  );
                },
                onMutedPeople: () {
                  AvelonHomeShell.of(context)?.closeMenu();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider<MutedUsersCubit>(
                        create: (context) =>
                        MutedUsersCubit(MutedUsersService())..fetchMutedUsers(),
                        child: const MutedUsersScreen(),
                      ),
                    ),
                  );
                },

                onLogout: () {
                  _showLogoutDialog(context);
                },
              ),
              body: Scaffold(
                backgroundColor: const Color(0xFFF1FDE1),
                appBar: const ProfileAppBar(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      UserHeaderCard(data: profileData),
                      const SizedBox(height: 16),
                      ActionButtonsRow(profileData: profileData),
                      const SizedBox(height: 20),
                      _buildTabBar(context, state.activeTabIndex),
                      const SizedBox(height: 16),
                      if (state.activeTabIndex == 0) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: PostInputSection(),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: activeContent,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
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
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
              size: 14,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      title: const Text(
        'A V E L O N',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.5,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Builder(builder: (innerContext) {
                return IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.black54,
                      size: 20,
                    ),
                    onPressed: () {
                      final shell = AvelonHomeShell.of(context);
                      print(shell);
                      shell?.toggleMenu();
                    });
              })),
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