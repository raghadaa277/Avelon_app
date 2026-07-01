import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchTile extends StatelessWidget {
  const SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.activeColor,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final Color activeColor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8F4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.black54),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5, color: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 10.5, color: Colors.grey[500]),
      ),
      trailing: Transform.scale(
        scale: 0.85,
        child: Switch(
          value: value,
          activeColor: Colors.white,
          activeTrackColor: activeColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFE2E3DD),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          onChanged: onChanged,
        ),
      ),
    );
  }
}