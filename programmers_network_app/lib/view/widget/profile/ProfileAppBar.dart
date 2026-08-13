import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../data/models/Profile/profile_model.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key, this.data, this.onMenuPressed});

  final ProfileData? data;
  final VoidCallback? onMenuPressed;

  static const Color accent = Color(0xFFB8FF1A);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,

      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 20,
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowLeft01,
              size: 18,
              color: Color(0xFF4B5563),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),

      // ─────────────────────────────────────
      // TITLE
      // ─────────────────────────────────────
      title: const Text(
        'A V E L O N',
        style: TextStyle(
          color: Color(0xFF111827),
          fontSize: 14,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.5,
        ),
      ),

      centerTitle: true,

      // ─────────────────────────────────────
      // MENU BUTTON
      // ─────────────────────────────────────
      actions: [
        if (data != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                splashRadius: 20,
                padding: EdgeInsets.zero,
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedMoreHorizontal,
                  size: 21,
                  color: Color(0xFF4B5563),
                ),
                onPressed: onMenuPressed,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
