import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_overview_model.dart';
import 'package:programmers_network_app/view/widget/Home/overview/overview_matric_card_widget.dart';

class OverviewMetricsGridWidget extends StatelessWidget {
  final DataOverviewModel data;

  const OverviewMetricsGridWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _MetricData(
        title: 'Profile Views',
        value: _format(data.profileViews),
        subtitle: 'Total views',
        icon: HugeIcons.strokeRoundedView,
        iconColor: Colors.pink,
        iconBackground: const Color(0xFFFFE8F0),
      ),

      _MetricData(
        title: 'Followers',
        value: _format(data.followersCount),
        subtitle: 'Total followers',
        icon: HugeIcons.strokeRoundedUserGroup,
        iconColor: const Color(0xFF22C55E),
        iconBackground: const Color(0xFFE8F8EF),
      ),

      _MetricData(
        title: 'Unfollowers',
        value: _format(data.unfollowers),
        subtitle: 'Total unfollowers',
        icon: HugeIcons.strokeRoundedUserRemove01,
        iconColor: Colors.pink,
        iconBackground: const Color(0xFFFFE8F0),
      ),

      _MetricData(
        title: 'Posts',
        value: _format(data.postCount),
        subtitle: 'Total posts',
        icon: HugeIcons.strokeRoundedFile01,
        iconColor: const Color(0xFF3B82F6),
        iconBackground: const Color(0xFFEAF3FF),
      ),

      _MetricData(
        title: 'Likes',
        value: _format(data.likesReceived),
        subtitle: 'Total likes',
        icon: HugeIcons.strokeRoundedFavourite,
        iconColor: Colors.pink,
        iconBackground: const Color(0xFFFFE8F0),
      ),

      _MetricData(
        title: 'Dislikes',
        value: _format(data.dislikeReceived),
        subtitle: 'Total dislikes',
        icon: HugeIcons.strokeRoundedThumbsDown,
        iconColor: const Color(0xFFF59E0B),
        iconBackground: const Color(0xFFFFF4DD),
      ),

      _MetricData(
        title: 'Comments',
        value: _format(data.commentsReceived),
        subtitle: 'Total comments',
        icon: HugeIcons.strokeRoundedMessage01,
        iconColor: const Color(0xFF3B82F6),
        iconBackground: const Color(0xFFEAF3FF),
      ),

      _MetricData(
        title: 'Saves',
        value: _format(data.saveReceived),
        subtitle: 'Total saves',
        icon: HugeIcons.strokeRoundedBookmark01,
        iconColor: Colors.pink,
        iconBackground: const Color(0xFFFFE8F0),
      ),

      _MetricData(
        title: 'Profile Search Impressions',
        value: _format(data.profileSearchImpressions),
        subtitle: 'Total impressions',
        icon: HugeIcons.strokeRoundedSearch01,
        iconColor: const Color(0xFF14B8A6),
        iconBackground: const Color(0xFFE6F9F6),
      ),

      _MetricData(
        title: 'Post Search Impressions',
        value: _format(data.postSearchImpressions),
        subtitle: 'Total impressions',
        icon: HugeIcons.strokeRoundedSearch01,
        iconColor: const Color(0xFFF59E0B),
        iconBackground: const Color(0xFFFFF4DD),
      ),

      _MetricData(
        title: 'Suggestion Impressions',
        value: _format(data.suggestionImpressions),
        subtitle: 'Total impressions',
        icon: HugeIcons.strokeRoundedSent,
        iconColor: Colors.pink,
        iconBackground: const Color(0xFFFFE8F0),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          for (int i = 0; i < metrics.length; i++) ...[
            OverviewMetricCardWidget(
              title: metrics[i].title,
              value: metrics[i].value,
              subtitle: metrics[i].subtitle,
              icon: metrics[i].icon,
              iconColor: metrics[i].iconColor,
              iconBackground: metrics[i].iconBackground,
            ),

            if (i != metrics.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  static String _format(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}

class _MetricData {
  final String title;
  final String value;
  final String subtitle;
  final dynamic icon;
  final Color iconColor;
  final Color iconBackground;

  const _MetricData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });
}
