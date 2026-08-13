import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import '../../../data/models/Profile/profile_model.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage({
    super.key,
    required this.data,
    this.onSettings,
    this.onActivity,
    this.onArchive,
    this.onTimeManagement,
    this.onBlockTracking,
    this.onFollowingTracking,
    this.onFavoritePeople,
    this.onMutedPeople,
    this.onDashboard,
    this.onLogout,
    this.onStatusUser,
    this.onSave,
    this.activity,
    this.onTimeLine,
  });

  final ProfileData data;

  final VoidCallback? onSettings;
  final VoidCallback? onStatusUser;
  final VoidCallback? onActivity;
  final VoidCallback? activity;
  final VoidCallback? onArchive;
  final VoidCallback? onTimeManagement;
  final VoidCallback? onBlockTracking;
  final VoidCallback? onFollowingTracking;
  final VoidCallback? onFavoritePeople;
  final VoidCallback? onMutedPeople;
  final VoidCallback? onDashboard;
  final VoidCallback? onLogout;
  final VoidCallback? onSave;
  final VoidCallback? onTimeLine;

  static const Color accent = Color(0xFFB8FF1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,

      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            size: 22,
            color: Color(0xFF1F2937),
          ),
        ),

        title: const Text(
          'Menu',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
          children: [
            _ProfileHeader(data: data),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Account',
              subtitle: 'Manage your account and preferences',
              icon: HugeIcons.strokeRoundedUserAccount,
            ),

            const SizedBox(height: 10),

            _MenuSection(
              children: [
                _MenuItem(
                  icon: HugeIcons.strokeRoundedSettings01,
                  label: 'Settings',
                  subtitle: 'Manage your app preferences',
                  tint: const Color(0xFFF1F1F1),
                  iconColor: Colors.blueGrey,
                  onTap: onSettings,
                ),

                _MenuItem(
                  icon: HugeIcons.strokeRoundedUserAccount,
                  label: 'Account Status',
                  subtitle: 'Check your account status',
                  tint: const Color(0xFFE9F7E5),
                  iconColor: Colors.green,
                  onTap: onStatusUser,
                ),
              ],
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Your Activity',
              subtitle: 'Keep track of your content and activity',
              icon: HugeIcons.strokeRoundedActivity01,
            ),

            const SizedBox(height: 10),

            _MenuSection(
              children: [
                _MenuItem(
                  icon: HugeIcons.strokeRoundedClock01,
                  label: 'User Activity',
                  subtitle: 'See your recent activity',
                  tint: const Color(0xFFE1F7F3),
                  iconColor: Colors.teal,
                  onTap: onTimeManagement,
                ),
                _MenuItem(
                  icon: HugeIcons.strokeRoundedActivity01,
                  label: 'Activities',
                  subtitle: 'View your activities posts',
                  tint: const Color(0xFFFBF0E4),
                  iconColor: Colors.deepOrangeAccent,
                  onTap: activity,
                ),
                _MenuItem(
                  icon: HugeIcons.strokeRoundedArchive02,
                  label: 'Archive',
                  subtitle: 'View your archived posts',
                  tint: const Color(0xFFFBF0E4),
                  iconColor: Colors.brown,
                  onTap: onArchive,
                ),

                _MenuItem(
                  icon: HugeIcons.strokeRoundedBookmark02,
                  label: 'Saved Posts',
                  subtitle: 'Posts you saved for later',
                  tint: const Color(0xFFF3E8FD),
                  iconColor: Colors.purple,
                  onTap: onSave,
                ),
              ],
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Connections',
              subtitle: 'Manage the people and relationships you follow',
              icon: HugeIcons.strokeRoundedUserGroup,
            ),

            const SizedBox(height: 10),

            _MenuSection(
              children: [
                _MenuItem(
                  icon: HugeIcons.strokeRoundedUserGroup,
                  label: 'Following Tracking',
                  subtitle: 'Track your following activity',
                  tint: const Color(0xFFEAEBFB),
                  iconColor: Colors.indigo,
                  onTap: onFollowingTracking,
                ),

                _MenuItem(
                  icon: HugeIcons.strokeRoundedFavourite,
                  label: 'Favorite People',
                  subtitle: 'People you marked as favorites',
                  tint: const Color(0xFFFFEDF3),
                  iconColor: const Color(0xFFE85D8E),
                  onTap: onFavoritePeople,
                ),

                _MenuItem(
                  icon: HugeIcons.strokeRoundedVolumeMute02,
                  label: 'Muted People',
                  subtitle: 'Manage people you muted',
                  tint: const Color(0xFFFEF0E4),
                  iconColor: Colors.orange,
                  onTap: onMutedPeople,
                ),
              ],
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Privacy & Safety',
              subtitle: 'Control your privacy and protection',
              icon: HugeIcons.strokeRoundedShield01,
            ),

            const SizedBox(height: 10),

            _MenuSection(
              children: [
                _MenuItem(
                  icon: HugeIcons.strokeRoundedShield01,
                  label: 'Block Tracking',
                  subtitle: 'Manage blocked users and activity',
                  tint: const Color(0xFFFDEBEA),
                  iconColor: Colors.red,
                  onTap: onBlockTracking,
                ),
              ],
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Insights',
              subtitle: 'Understand your profile and performance',
              icon: HugeIcons.strokeRoundedDashboardSquare01,
            ),

            const SizedBox(height: 10),

            _MenuSection(
              children: [
                _MenuItem(
                  icon: HugeIcons.strokeRoundedDashboardSquare01,
                  label: 'Dashboard',
                  subtitle: 'View your profile insights',
                  tint: const Color(0xFFE4F6FB),
                  iconColor: Colors.cyan,
                  onTap: onDashboard,
                ),
              ],
            ),

            _MenuSection(
              children: [
                _MenuItem(
                  icon: HugeIcons.strokeRoundedTimeline,
                  label: 'TimeLine',
                  subtitle: 'View your profile timeLine',
                  tint: const Color(0xFFE4F6FB),
                  iconColor: Colors.pink,
                  onTap: onTimeLine,
                ),
              ],
            ),

            const SizedBox(height: 30),

            _LogoutTile(onTap: onLogout),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.data});

  final ProfileData data;

  static const Color accent = Color(0xFFB8FF1A);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: const Color(0xFFEFF0F1)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2.5),

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 2),
            ),

            child: CircleAvatar(
              radius: 29,

              backgroundColor: const Color(0xFFF0F1F2),

              backgroundImage: data.avatarFullUrl != null
                  ? NetworkImage(data.avatarFullUrl!)
                  : null,

              child: data.avatarFullUrl == null
                  ? const Icon(Icons.person, size: 28, color: Colors.grey)
                  : null,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        data.fullName,
                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),

                    const Icon(Icons.check_circle, color: accent, size: 16),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  '@${data.username}',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final List<List> icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),

      child: Row(
        children: [
          HugeIcon(icon: icon, size: 18, color: const Color(0xFF6B7280)),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  style: TextStyle(fontSize: 10.5, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFEDEEEF)),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),

        child: Column(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],

              if (i != children.length - 1)
                const Divider(
                  height: 1,
                  indent: 64,
                  endIndent: 16,
                  color: Color(0xFFF1F2F3),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.tint,
    required this.iconColor,
    this.onTap,
  });

  final List<List> icon;
  final String label;
  final String subtitle;
  final Color tint;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),

          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,

                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Center(
                  child: HugeIcon(icon: icon, size: 19, color: iconColor),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,

                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 10.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 17,
                color: Color(0xFFB8BCC2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutTile extends StatelessWidget {
  const _LogoutTile({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

          decoration: BoxDecoration(
            color: const Color(0xFFFFF4F3),
            borderRadius: BorderRadius.circular(17),

            border: Border.all(color: const Color(0xFFFFDCD9)),
          ),

          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,

                decoration: BoxDecoration(
                  color: const Color(0xFFFFE3E0),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Center(
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedLogout01,
                    size: 19,
                    color: Colors.red,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      'Sign out of your account',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFFB56B67),
                      ),
                    ),
                  ],
                ),
              ),

              const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 17,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
