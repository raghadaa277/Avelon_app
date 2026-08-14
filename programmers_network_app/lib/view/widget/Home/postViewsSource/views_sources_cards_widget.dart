import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/view/widget/Home/postViewsSource/view_source_card_widget.dart';

class ViewsSourceCards extends StatelessWidget {
  final int feedCount;
  final int searchCount;
  final int profileCount;

  final double feedPercentage;
  final double searchPercentage;
  final double profilePercentage;

  const ViewsSourceCards({
    super.key,
    required this.feedCount,
    required this.searchCount,
    required this.profileCount,
    required this.feedPercentage,
    required this.searchPercentage,
    required this.profilePercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewSourceCard(
            title: 'Feed',
            count: feedCount,
            percentage: feedPercentage,
            icon: HugeIcons.strokeRoundedHome01,
            color: const Color.fromARGB(255, 223, 102, 136),
            lightColor: const Color(0xFFF0EBFF),
          ),

          const SizedBox(width: 10),

          ViewSourceCard(
            title: 'Search',
            count: searchCount,
            percentage: searchPercentage,
            icon: HugeIcons.strokeRoundedSearch01,
            color: const Color(0xFF2F80ED),
            lightColor: const Color(0xFFEAF4FF),
          ),

          const SizedBox(width: 10),

          ViewSourceCard(
            title: 'Profile',
            count: profileCount,
            percentage: profilePercentage,
            icon: HugeIcons.strokeRoundedUser,
            color: const Color(0xFF25AE7A),
            lightColor: const Color(0xFFE9FAF3),
          ),
        ],
      ),
    );
  }
}
