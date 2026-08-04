import 'package:flutter/material.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_theme_widget.dart';

class ProfileStatsWidget extends StatelessWidget {
  final int postsCount;
  final int followersCount;
  final int followingCount;

  final VoidCallback? onFollowersTap;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onPostsTap;

  const ProfileStatsWidget({
    super.key,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    this.onFollowersTap,
    this.onFollowingTap,
    this.onPostsTap,
  });

  static String _compact(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }

    return '$value';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),

      decoration: BoxDecoration(
        color: ProfileTheme.pageBg,

        borderRadius: BorderRadius.circular(ProfileTheme.radiusM),
      ),

      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              value: _compact(postsCount),

              label: 'Posts',

              onTap: onPostsTap,
            ),
          ),

          const _VerticalDivider(),

          Expanded(
            child: _StatItem(
              value: _compact(followersCount),

              label: 'Followers',

              onTap: onFollowersTap,
            ),
          ),

          const _VerticalDivider(),

          Expanded(
            child: _StatItem(
              value: _compact(followingCount),

              label: 'Following',

              onTap: onFollowingTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? onTap;

  const _StatItem({required this.value, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(10),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),

        child: Column(
          children: [
            Text(
              value,

              style: const TextStyle(
                fontSize: 16,

                fontWeight: FontWeight.w700,

                color: ProfileTheme.textDark,
              ),
            ),

            const SizedBox(height: 2),

            Text(label, style: ProfileTheme.subtleStyle),
          ],
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 28, color: ProfileTheme.divider);
  }
}
