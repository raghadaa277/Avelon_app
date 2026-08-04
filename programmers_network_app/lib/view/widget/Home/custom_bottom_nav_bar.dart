import 'package:flutter/material.dart';
import '../../screen/profile/profile_page.dart'; // تأكدي من صحة المسار

class CustomBottomNavBar extends StatelessWidget {
  // 🟢 أضفنا هذا المتغير لتحديد التابة النشطة (0: Home, 1: Explore, 3: Notifications, 4: Profile)
  final int selectedIndex;

  const CustomBottomNavBar({super.key, this.selectedIndex = 0}); // الافتراضي هو الهوم (0)

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildNavItem(
              context,
              Icons.home_outlined,
              'Home',
              selectedIndex == 0, // تضيء إذا كان الاندكس 0
              onTap: () {
                if (selectedIndex != 0) {
                  Navigator.popUntil(context, (route) => route.isFirst); // العودة للهوم
                }
              },
            ),
          ),
          Expanded(
            child: _buildNavItem(
              context,
              Icons.search,
              'Explore',
              selectedIndex == 1,
              onTap: () {},
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xffB8FF1A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.add, color: Colors.black, size: 24),
              ),
            ),
          ),
          Expanded(
            child: _buildNavItem(
              context,
              Icons.notifications_none,
              'Notifications',
              selectedIndex == 3,
              onTap: () {},
            ),
          ),
          Expanded(
            child: _buildNavItem(
              context,
              Icons.person_outline,
              'Profile',
              selectedIndex == 4, // تضيء أخضر فسفوري إذا كنا بالبروفايل أو إضافة المهارات!
              onTap: () {
                if (selectedIndex != 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context,
      IconData icon,
      String label,
      bool isActive, {
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            // 🟢 إذا كانت النشطة نلونها بالفسفوري 0xffB8FF1A متل كودك
            color: isActive ? const Color(0xffB8FF1A) : Colors.grey[400],
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey[400],
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}