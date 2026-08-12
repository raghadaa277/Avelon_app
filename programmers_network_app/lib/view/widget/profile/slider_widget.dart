import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../data/models/Profile/profile_model.dart';

class AvelonHomeShell extends StatefulWidget {
  const AvelonHomeShell({super.key, required this.body, required this.menu});

  final Widget body;
  final Widget menu;
  // ignore: library_private_types_in_public_api
  static _AvelonHomeShellState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AvelonHomeShellState>();

  @override
  State<AvelonHomeShell> createState() => _AvelonHomeShellState();
}

class _AvelonHomeShellState extends State<AvelonHomeShell> {
  bool isMenuOpen = false;

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);
  void closeMenu() => setState(() => isMenuOpen = false);

  static const _duration = Duration(milliseconds: 280);
  static const _curve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.60;

    return PopScope(
      canPop: !isMenuOpen,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isMenuOpen) {
          closeMenu();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: _duration,
              curve: _curve,
              top: 0,
              bottom: 0,
              right: isMenuOpen ? 0 : -drawerWidth,
              width: drawerWidth,
              child: widget.menu,
            ),

            AnimatedPositioned(
              duration: _duration,
              curve: _curve,
              top: 0,
              bottom: 0,
              left: isMenuOpen ? -drawerWidth : 0,
              right: isMenuOpen ? drawerWidth : 0,
              child: GestureDetector(
                onTap: isMenuOpen ? closeMenu : null,
                child: AnimatedScale(
                  duration: _duration,
                  curve: _curve,
                  scale: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Stack(
                      children: [
                        widget.body,

                        AnimatedOpacity(
                          duration: _duration,
                          opacity: isMenuOpen ? 0.45 : 0,
                          child: IgnorePointer(
                            ignoring: !isMenuOpen,
                            child: Container(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSideMenu extends StatelessWidget {
  const ProfileSideMenu({
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
  });

  final ProfileData data;
  final VoidCallback? onSettings;
  final VoidCallback? onStatusUser;
  final VoidCallback? onActivity;
  final VoidCallback? onArchive;
  final VoidCallback? onTimeManagement;
  final VoidCallback? onBlockTracking;
  final VoidCallback? onFollowingTracking;
  final VoidCallback? onFavoritePeople;
  final VoidCallback? onMutedPeople;
  final VoidCallback? onDashboard;
  final VoidCallback? onLogout;
  final VoidCallback? onSave;

  static const _accent = Color(0xffB8FF1A);
  static const _tint = Color(0xFFF1FDE1);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFCFDF8),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        bottomLeft: Radius.circular(28),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  _Header(data: data, accent: _accent),
            const SizedBox(height: 12),
            const SizedBox(height: 4),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 4),
                children: [
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedSettings01,
                    label: 'Settings',
                    tint: const Color(0xFFF1F1F1),
                    iconColor: Colors.blueGrey,
                    onTap: onSettings,
                  ),

                  _MenuItem(
                    icon: HugeIcons.strokeRoundedArchive02,
                    label: 'Archive',
                    tint: const Color(0xFFFBF0E4),
                    iconColor: Colors.brown,
                    onTap: onArchive,
                  ),
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedBookmark02,
                    label: 'Save posts',
                    tint: const Color(0xFFF3E8FD),
                    iconColor: Colors.purple,
                    onTap: onSave,
                  ),
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedClock01,
                    label: 'User Activity',
                    tint: const Color(0xFFE1F7F3),
                    iconColor: Colors.teal,
                    onTap: onTimeManagement,
                  ),
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedUserAccount,
                    label: 'Account Status',
                    tint: const Color(0xFFE9F7E5),
                    iconColor: Colors.green,
                    onTap: onStatusUser,
                  ),
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedShield01,
                    label: 'Block Tracking',
                    tint: const Color(0xFFFDEBEA),
                    iconColor: Colors.red,
                    onTap: onBlockTracking,
                  ),
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedUserGroup,
                    label: 'Following Tracking',
                    tint: const Color(0xFFEAEBFB),
                    iconColor: Colors.indigo,
                    onTap: onFollowingTracking,
                  ),
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedFavourite,
                    label: 'Favorite People',
                    tint: _tint,
                    iconColor: _accent,
                    onTap: onFavoritePeople,
                  ),
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedVolumeMute02,
                    label: 'Muted People',
                    tint: const Color(0xFFFEF0E4),
                    iconColor: Colors.orange,
                    onTap: onMutedPeople,
                  ),
                  _MenuItem(
                    icon: HugeIcons.strokeRoundedDashboardSquare01,
                    label: 'Dashboard',
                    tint: const Color(0xFFE4F6FB),
                    iconColor: Colors.cyan,
                    onTap: onDashboard,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(height: 1, indent: 20, endIndent: 20),
                  ),
                  _LogoutTile(onTap: onLogout),
                ],
              ),
            ),
            //const _Footer(),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _Header extends StatelessWidget {
  const _Header({required this.data, required this.accent});

  final ProfileData data;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(28)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFFFCFDF8), accent.withValues(alpha: 0.10)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _WavePainter(color: accent.withValues(alpha: 0.22)),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: accent, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFEFEFEF),
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
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.check_circle, color: accent, size: 16),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@${data.username}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < 4; i++) {
      final path = Path();
      final startY = size.height * (0.35 + i * 0.14);
      path.moveTo(size.width * 0.35, startY);
      path.quadraticBezierTo(
        size.width * 0.75,
        startY - 18,
        size.width + 20,
        startY + 30,
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.tint,
    this.iconColor,
    this.onTap,
  });

  final List<List> icon;
  final String label;
  final Color tint;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      minVerticalPadding: 4,

      leading: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(10),
        ),
        child: HugeIcon(
          icon: icon,
          size: 18,
          color: iconColor ?? Colors.black87,
        ),
      ),

      title: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),

      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
    );
  }
}

class _LogoutTile extends StatelessWidget {
  const _LogoutTile({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F0),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFD9D6)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: HugeIcon(
          icon: HugeIcons.strokeRoundedLogout01,
          color: Colors.red,
        ),
        title: const Text(
          'Log out',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
