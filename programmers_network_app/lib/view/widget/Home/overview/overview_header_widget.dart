import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class OverviewHeaderWidget extends StatelessWidget {
  final VoidCallback onBack;

  const OverviewHeaderWidget({super.key, required this.onBack});

  static const Color primaryColor = Color.fromARGB(255, 206, 241, 130);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          _HeaderButton(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            onTap: onBack,
          ),

          const Expanded(
            child: Column(
              children: [
                Text(
                  'Overview Metrics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Track your key performance metrics',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final dynamic icon;
  final VoidCallback onTap;

  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Center(
            child: HugeIcon(
              icon: icon,
              size: 22,
              color: const Color(0xFF374151),
            ),
          ),
        ),
      ),
    );
  }
}
