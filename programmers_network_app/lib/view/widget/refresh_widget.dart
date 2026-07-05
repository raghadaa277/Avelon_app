import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  final VoidCallback onRefresh;
  final String? label;

  const RefreshButton({super.key, required this.onRefresh, this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRefresh,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xffB8FF1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.refresh_rounded, size: 16, color: Colors.black),
            const SizedBox(width: 6),
            Text(
              label ?? "Refresh",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
