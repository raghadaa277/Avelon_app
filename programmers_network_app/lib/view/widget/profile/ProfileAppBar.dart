import 'package:flutter/material.dart';
import 'slider_widget.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Builder(
              builder: (innerContext) {
                return IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.black54,
                    size: 20,
                  ),
                  onPressed: () {
                    final shell = AvelonHomeShell.of(innerContext);
                    print("Shell context initialized: $shell");
                    shell?.toggleMenu();
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
