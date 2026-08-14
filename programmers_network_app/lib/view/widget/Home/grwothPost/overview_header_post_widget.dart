import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class OverviewHeaderPostWidget extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onCalendarTap;

  const OverviewHeaderPostWidget({
    super.key,
    required this.onBack,
    this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF172033);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Row(
        children: [
          _HeaderButton(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            onTap: onBack,
          ),

          const Expanded(
            child: Center(
              child: Text(
                'Views Overview',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
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
