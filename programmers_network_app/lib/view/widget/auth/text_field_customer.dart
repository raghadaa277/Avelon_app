import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class TextFieldCustomer extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;

  final dynamic icon;

  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final Function(String)? onChanged;
  final TextInputType keyboardType;

  const TextFieldCustomer({
    super.key,
    required this.label,
    required this.icon,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.onSuffixTap,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Row(
        children: [
          HugeIcon(icon: icon, size: 22, color: const Color(0xFF9CA3AF)),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9CA3AF),
                  ),
                ),

                const SizedBox(height: 6),

                TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  keyboardType: keyboardType,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9CA3AF),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),

          if (onSuffixTap != null)
            GestureDetector(
              onTap: onSuffixTap,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: HugeIcon(
                  key: ValueKey(obscureText),
                  icon: obscureText
                      ? HugeIcons.strokeRoundedView
                      : HugeIcons.strokeRoundedViewOff,
                  size: 22,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
