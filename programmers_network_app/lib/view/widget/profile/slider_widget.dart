import 'package:flutter/material.dart';
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
        child:Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: _duration,
            curve: _curve,
            top: 0,
            bottom: 0,
            right : isMenuOpen ? 0 : -drawerWidth,
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
        ));
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
  });

  final ProfileData data;
  final VoidCallback? onSettings;
  final VoidCallback? onActivity;
  final VoidCallback? onArchive;
  final VoidCallback? onTimeManagement;
  final VoidCallback? onBlockTracking;
  final VoidCallback? onFollowingTracking;
  final VoidCallback? onFavoritePeople;
  final VoidCallback? onMutedPeople;
  final VoidCallback? onDashboard;
  final VoidCallback? onLogout;

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
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    tint: _tint,
                    onTap: onSettings,
                  ),
                  _MenuItem(
                    icon: Icons.notifications_none_rounded,
                    label: 'Activity',
                    tint: _tint,
                    onTap: onActivity,
                  ),
                  _MenuItem(
                    icon: Icons.inventory_2_outlined,
                    label: 'Archive',
                    tint: _tint,
                    onTap: onArchive,
                  ),
                  _MenuItem(
                    icon: Icons.access_time_rounded,
                    label: 'Time Management',
                    tint: _tint,
                    onTap: onTimeManagement,
                  ),
                  _MenuItem(
                    icon: Icons.shield_outlined,
                    label: 'Block Tracking',
                    tint: _tint,
                    onTap: onBlockTracking,
                  ),
                  _MenuItem(
                    icon: Icons.group_outlined,
                    label: 'Following Tracking',
                    tint: _tint,
                    onTap: onFollowingTracking,
                  ),
                  _MenuItem(
                    icon: Icons.star_border_rounded,
                    label: 'Favorite People',
                    tint: _tint,
                    iconColor: _accent,
                    onTap: onFavoritePeople,
                  ),
                  _MenuItem(
                    icon: Icons.volume_off_outlined,
                    label: 'Muted People',
                    tint: _tint,
                    onTap: onMutedPeople,
                  ),
                  _MenuItem(
                    icon: Icons.grid_view_rounded,
                    label: 'Dashboard',
                    tint: _tint,
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

  final IconData icon;
  final String label;
  final Color tint;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 19, color: iconColor ?? Colors.black87),
      ),
      title: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
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
        leading: const Icon(Icons.logout_rounded, color: Colors.red, size: 20),
        title: const Text(
          'Log out',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}





