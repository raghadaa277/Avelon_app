import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class FollowButton extends StatelessWidget {
  final String followStatus;

  final VoidCallback onFollow;
  final VoidCallback onFollowBack;
  final VoidCallback onUnfollow;

  const FollowButton({
    super.key,
    required this.followStatus,
    required this.onFollow,
    required this.onFollowBack,
    required this.onUnfollow,
  });

  @override
  Widget build(BuildContext context) {
    switch (followStatus.toLowerCase()) {
      case 'following':
      case 'mutual':
        return PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'unfollow') {
              onUnfollow();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'unfollow',
              child: Row(
                children: [
                  HugeIcon(
                    size: 18,
                    color: Colors.red,
                    icon: HugeIcons.strokeRoundedUserRemove01,
                  ),
                  SizedBox(width: 10),
                  Text("Unfollow", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: const Color(0xffE9FFD1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Following",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        );

      case 'follower':
        return SizedBox(
          height: 46,
          child: ElevatedButton(
            onPressed: onFollowBack,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffE9FFD1),
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Follow Back",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );

      default:
        return SizedBox(
          height: 46,
          child: ElevatedButton(
            onPressed: onFollow,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffD9FF95),
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Follow",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );
    }
  }
}
