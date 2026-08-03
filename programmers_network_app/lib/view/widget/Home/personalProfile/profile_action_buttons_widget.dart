import 'package:flutter/material.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_theme_widget.dart';

enum ProfileMenuAction { toggleCloseFriend, toggleMute, report }

class ProfileActionButtonsWidget extends StatelessWidget {
  final String followStatus;
  final bool isCloseFriend;
  final bool isMuted;
  final bool isFlagged;

  final VoidCallback onFollow;
  final VoidCallback onUnfollow;
  final VoidCallback onMessage;
  final VoidCallback onShare;
  final ValueChanged<ProfileMenuAction> onMenuSelected;

  const ProfileActionButtonsWidget({
    super.key,
    required this.followStatus,
    required this.onFollow,
    required this.onUnfollow,
    required this.onMessage,
    required this.onShare,
    required this.onMenuSelected,
    this.isCloseFriend = false,
    this.isMuted = false,
    this.isFlagged = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildMainButton(context)),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: OutlinedButton.icon(
            onPressed: onMessage,
            icon: const Icon(Icons.chat_bubble_outline, size: 18),
            label: const Text('Message'),
            style: OutlinedButton.styleFrom(
              foregroundColor: ProfileTheme.textDark,
              side: const BorderSide(color: ProfileTheme.divider),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ProfileTheme.radiusM),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _buildMoreMenu(context),
      ],
    );
  }

  Widget _buildMainButton(BuildContext context) {
    switch (followStatus) {
      case 'following':
      case 'mutual':
        return _DropdownStyleButton(label: 'Following', onUnfollow: onUnfollow);
      case 'follower':
        return _SolidButton(label: 'Follow Back', onTap: onFollow);
      case 'none':
      default:
        return _SolidButton(label: 'Follow', onTap: onFollow);
    }
  }

  Widget _buildMoreMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ProfileTheme.divider),
        borderRadius: BorderRadius.circular(ProfileTheme.radiusM),
      ),
      child: PopupMenuButton<ProfileMenuAction>(
        icon: const Icon(
          Icons.ios_share,
          size: 20,
          color: ProfileTheme.textDark,
        ),
        onSelected: onMenuSelected,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: ProfileMenuAction.toggleCloseFriend,
            child: Row(
              children: [
                Icon(
                  isCloseFriend ? Icons.star : Icons.star_border,
                  size: 18,
                  color: ProfileTheme.closeFriendGold,
                ),
                const SizedBox(width: 10),
                Text(
                  isCloseFriend
                      ? 'Remove from Close Friends'
                      : 'Add to Close Friends',
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: ProfileMenuAction.toggleMute,
            child: Row(
              children: [
                Icon(
                  isMuted ? Icons.volume_up : Icons.volume_off,
                  size: 18,
                  color: ProfileTheme.mutedOrange,
                ),
                const SizedBox(width: 10),
                Text(isMuted ? 'Unmute' : 'Mute'),
              ],
            ),
          ),
          PopupMenuItem(
            value: ProfileMenuAction.report,
            enabled: !isFlagged,
            child: Row(
              children: [
                Icon(Icons.flag, size: 18, color: ProfileTheme.reportedRed),
                const SizedBox(width: 10),
                Text(isFlagged ? 'Reported' : 'Report'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SolidButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SolidButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: ProfileTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ProfileTheme.radiusM),
        ),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _DropdownStyleButton extends StatelessWidget {
  final String label;
  final VoidCallback onUnfollow;
  const _DropdownStyleButton({required this.label, required this.onUnfollow});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (_) => onUnfollow(),
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'unfollow', child: Text('Unfollow')),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: ProfileTheme.lightGreenBg,
          borderRadius: BorderRadius.circular(ProfileTheme.radiusM),
          border: Border.all(color: ProfileTheme.lightGreenBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: ProfileTheme.primaryGreenDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: ProfileTheme.primaryGreenDark,
            ),
          ],
        ),
      ),
    );
  }
}
