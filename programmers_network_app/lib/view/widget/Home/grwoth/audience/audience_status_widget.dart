import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:programmers_network_app/data/models/Home/growth/get_post_audience_model.dart';

class AudienceStatCardsWidget extends StatelessWidget {
  final GetPostAudienceModel data;

  const AudienceStatCardsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AudienceStatCard(
            title: 'Followers',
            views: data.followersViews,
            percentage: data.followersPercentage,
            color: Color.fromARGB(255, 211, 60, 103),
            backgroundColor: const Color(0xFFF0F8E7),
            icon: HugeIcons.strokeRoundedUserGroup,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _AudienceStatCard(
            title: 'Non-followers',
            views: data.nonFollowersViews,
            percentage: data.nonFollowersPercentage,
            color: Color.fromARGB(255, 211, 60, 103),
            backgroundColor: const Color(0xFFF5F9ED),
            icon: HugeIcons.strokeRoundedUser,
          ),
        ),
      ],
    );
  }
}

class _AudienceStatCard extends StatelessWidget {
  final String title;
  final int views;
  final double percentage;
  final Color color;
  final Color backgroundColor;
  final List<List<dynamic>> icon;

  const _AudienceStatCard({
    required this.title,
    required this.views,
    required this.percentage,
    required this.color,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFE8ECE8)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,

                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Center(
                  child: HugeIcon(icon: icon, size: 23, color: color),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            '$views',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),

          Text(
            '${percentage.toStringAsFixed(2)}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),

          const SizedBox(height: 9),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 6,

              backgroundColor: const Color(0xFFEEF0ED),

              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
