import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_growth_model.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/matric_widget.dart';

class GrowthGrid extends StatefulWidget {
  final Growth growth;

  const GrowthGrid({super.key, required this.growth});

  @override
  State<GrowthGrid> createState() => _GrowthGridState();
}

class _GrowthGridState extends State<GrowthGrid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GrowthMetricCard(
                title: 'Profile Views',
                data: widget.growth.profileViews,
                icon: HugeIcons.strokeRoundedView,
                iconColor: const Color(0xFF6D3DF5),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GrowthMetricCard(
                title: 'Followers',
                data: widget.growth.followers,
                icon: HugeIcons.strokeRoundedUserGroup,
                iconColor: const Color(0xFF2196F3),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: GrowthMetricCard(
                title: 'Posts',
                data: widget.growth.posts,
                icon: HugeIcons.strokeRoundedFile02,
                iconColor: const Color(0xFFE6A229),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GrowthMetricCard(
                title: 'Likes',
                data: widget.growth.likes,
                icon: HugeIcons.strokeRoundedFavourite,
                iconColor: const Color(0xFFE83E8C),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: GrowthMetricCard(
                title: 'Comments',
                data: widget.growth.comments,
                icon: HugeIcons.strokeRoundedComment01,
                iconColor: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GrowthMetricCard(
                title: 'Saves',
                data: widget.growth.saves,
                icon: HugeIcons.strokeRoundedBookmark02,
                iconColor: const Color(0xFF6D3DF5),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        GrowthMetricCard(
          title: 'Search Impressions',
          data: widget.growth.search,
          icon: HugeIcons.strokeRoundedSearch01,
          iconColor: const Color(0xFF14B8A6),
          fullWidth: true,
        ),

        const SizedBox(height: 10),

        GrowthMetricCard(
          title: 'Suggestion Impressions',
          data: widget.growth.suggestions,
          icon: HugeIcons.strokeRoundedUserAdd01,
          iconColor: const Color(0xFFE6A229),
          fullWidth: true,
        ),
      ],
    );
  }
}
