import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ButtonCustomer extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const ButtonCustomer({super.key, required this.text, this.onTap});

  @override
  State<ButtonCustomer> createState() => _ButtonCustomerState();
}

class _ButtonCustomerState extends State<ButtonCustomer> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    const lime = Color(0xFFB7F51A);

    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
      },
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () {
        setState(() => isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: Matrix4.translationValues(0, isPressed ? 3 : 0, 0),
        height: 62,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: lime,
          borderRadius: BorderRadius.circular(31),
          boxShadow: [
            BoxShadow(
              color: lime.withValues(alpha: 0.45),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            const Spacer(),

            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            const Spacer(),

            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowRight01,
                  size: 18,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
