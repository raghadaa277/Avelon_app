import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_action_buttons_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_stats_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_theme_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/relationshipe_status_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/status_indictor_badge_widget.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String? avatarUrl;
  final String fullName;
  final String? username;
  final bool isVerified;
  final bool isOnline;
  final String? specialization;
  final String? city;
  final String? country;
  final String? bio;

  final int postsCount;
  final int followersCount;
  final int followingCount;

  final String followStatus;
  final bool isCloseFriend;
  final bool isMuted;
  final bool isFlagged;
  final bool isCloseFriendOf;
  final bool isMutedBy;
  final bool isFlaggedBy;

  final VoidCallback onFollow;
  final VoidCallback onUnfollow;
  final VoidCallback onMessage;
  final VoidCallback onShare;
  final ValueChanged<ProfileMenuAction> onMenuSelected;

  const ProfileHeaderWidget({
    super.key,
    required this.fullName,
    required this.followStatus,
    required this.onFollow,
    required this.onUnfollow,
    required this.onMessage,
    required this.onShare,
    required this.onMenuSelected,
    this.avatarUrl,
    this.username,
    this.isVerified = true,
    this.isOnline = false,
    this.specialization,
    this.city,
    this.country,
    this.bio,
    this.postsCount = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.isCloseFriend = false,
    this.isMuted = false,
    this.isFlagged = false,
    this.isCloseFriendOf = false,
    this.isMutedBy = false,
    this.isFlaggedBy = false,
  });

  @override
  Widget build(BuildContext context) {
    final location = [
      city,
      country,
    ].where((e) => e != null && e.isNotEmpty).join(', ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ProfileTheme.cardBg,
        borderRadius: BorderRadius.circular(ProfileTheme.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(url: avatarUrl, isOnline: isOnline),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            fullName,
                            style: ProfileTheme.nameStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            size: 17,
                            color: ProfileTheme.primaryGreen,
                          ),
                        ],
                        const SizedBox(width: 6),
                        StatusIndicatorRow(
                          isCloseFriend: isCloseFriend,
                          isMuted: isMuted,
                          isFlagged: isFlagged,
                          isCloseFriendOf: isCloseFriendOf,
                          isMutedBy: isMutedBy,
                          isFlaggedBy: isFlaggedBy,
                        ),
                      ],
                    ),
                    if (username != null)
                      Text('@$username', style: ProfileTheme.subtleStyle),
                    if (specialization != null &&
                        specialization!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      _Tag(text: specialization!),
                    ],

                    if (location.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _IconLine(
                        icon: HugeIcons.strokeRoundedLocation01,
                        text: location,
                      ),
                    ],
                    if (bio != null && bio!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      _IconLine(
                        icon: HugeIcons.strokeRoundedIdentityCard,
                        text: bio!,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ProfileStatsWidget(
            postsCount: postsCount,
            followersCount: followersCount,
            followingCount: followingCount,
          ),
          const SizedBox(height: 14),
          ProfileActionButtonsWidget(
            followStatus: followStatus,
            isCloseFriend: isCloseFriend,
            isMuted: isMuted,
            isFlagged: isFlagged,
            onFollow: onFollow,
            onUnfollow: onUnfollow,
            onMessage: onMessage,
            onShare: onShare,
            onMenuSelected: onMenuSelected,
          ),
          const SizedBox(height: 14),
          RelationshipStatusWidget(followStatus: followStatus),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? url;
  final bool isOnline;
  const _Avatar({required this.url, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: ProfileTheme.pageBg,
          backgroundImage: (url != null && url!.isNotEmpty)
              ? NetworkImage(url!)
              : null,
          child: (url == null || url!.isEmpty)
              ? const Icon(Icons.person, size: 34, color: ProfileTheme.textGrey)
              : null,
        ),
        if (isOnline)
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: ProfileTheme.primaryGreen,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: ProfileTheme.lightGreenBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ProfileTheme.lightGreenBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedCode,
            size: 13,
            color: ProfileTheme.primaryGreenDark,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ProfileTheme.primaryGreenDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  final List<List<dynamic>> icon;
  final String text;
  const _IconLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HugeIcon(icon: icon, size: 15, color: ProfileTheme.textGrey),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: ProfileTheme.subtleStyle)),
      ],
    );
  }
}
