import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class ViewsOverviewHeader extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onCalendarTap;

  const ViewsOverviewHeader({super.key, this.onBack, this.onCalendarTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderButton(
            icon: HugeIcons.strokeRoundedArrowLeft02,
            onTap: onBack ?? () => Navigator.pop(context),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              children: [
                const Text(
                  'Views Overview',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Understand where your views are coming from',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final List<List> icon;
  final VoidCallback? onTap;

  const _HeaderButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8E8EF)),
          ),
          child: Center(
            child: HugeIcon(
              icon: icon,
              size: 24,
              color: ColorConst.colorButton,
            ),
          ),
        ),
      ),
    );
  }
}
