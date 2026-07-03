import 'package:flutter/material.dart';
import '../../screen/profile/profile_page.dart'; 

class ProfileCompletionCard extends StatelessWidget {
  final String completionText;
  const ProfileCompletionCard({super.key, required this.completionText});

  @override
  Widget build(BuildContext context) {
    final cleanNumber = completionText.replaceAll('%', '').trim();
    final double progressValue = (double.tryParse(cleanNumber) ?? 0.0) / 100.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: progressValue,
                  strokeWidth: 2.5,
                  backgroundColor: Colors.grey[100],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xffB8FF1A),
                  ),
                ),
              ),
              Text(
                completionText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Complete your profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Add photo, bio and links to\nbuild your identity',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 10,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xffB8FF1A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Complete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_forward, size: 14, color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}