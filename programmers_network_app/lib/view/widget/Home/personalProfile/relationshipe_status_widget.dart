import 'package:flutter/material.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_theme_widget.dart';

class _StatusVisual {
  final IconData icon;
  final Color color;
  final String label;
  const _StatusVisual(this.icon, this.color, this.label);
}

_StatusVisual _visualFor(String followStatus) {
  switch (followStatus) {
    case 'following':
      return const _StatusVisual(
        Icons.person,
        ProfileTheme.followingGreen,
        'You follow this user',
      );
    case 'follower':
      return const _StatusVisual(
        Icons.person_outline,
        ProfileTheme.followerBlue,
        'This user follows you',
      );
    case 'mutual':
      return const _StatusVisual(
        Icons.people_alt,
        ProfileTheme.mutualPurple,
        'You follow each other (Mutual)',
      );
    case 'none':
    default:
      return const _StatusVisual(
        Icons.person_add_alt,
        ProfileTheme.noneGrey,
        'No relationship',
      );
  }
}

class RelationshipStatusWidget extends StatelessWidget {
  final String followStatus;

  const RelationshipStatusWidget({super.key, required this.followStatus});

  @override
  Widget build(BuildContext context) {
    final visual = _visualFor(followStatus);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ProfileTheme.purpleBg,
        borderRadius: BorderRadius.circular(ProfileTheme.radiusM),
        border: Border.all(color: ProfileTheme.purpleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('RELATIONSHIP STATUS', style: ProfileTheme.caption),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(visual.icon, size: 18, color: visual.color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  visual.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ProfileTheme.textDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
