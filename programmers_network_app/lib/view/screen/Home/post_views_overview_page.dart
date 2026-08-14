import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:programmers_network_app/controller/Home/get_grwoth_controller.dart';
import 'package:programmers_network_app/view/widget/Home/postViewsSource/top_sourc_widget.dart';
import 'package:programmers_network_app/view/widget/Home/postViewsSource/total_views_card_widget.dart';
import 'package:programmers_network_app/view/widget/Home/postViewsSource/views_bySource_chart_widget.dart';
import 'package:programmers_network_app/view/widget/Home/postViewsSource/views_overview_hewder_widget.dart';
import 'package:programmers_network_app/view/widget/Home/postViewsSource/views_sources_cards_widget.dart';

class PostViewsOverviewPage extends StatefulWidget {
  final int postId;

  const PostViewsOverviewPage({super.key, required this.postId});

  @override
  State<PostViewsOverviewPage> createState() => _PostViewsOverviewPageState();
}

class _PostViewsOverviewPageState extends State<PostViewsOverviewPage> {
  late final GrowthController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(GrowthController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPostViewsOverview(postId: widget.postId);
    });
  }

  @override
  void dispose() {
    Get.delete<GrowthController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: GetBuilder<GrowthController>(
          builder: (controller) {
            if (controller.isLoading && controller.postViewsOverview == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.isNotEmpty &&
                controller.postViewsOverview == null) {
              return _ErrorView(
                message: controller.errorMessage.value,
                onRetry: () {
                  controller.getPostViewsOverview(postId: widget.postId);
                },
              );
            }

            final response = controller.postViewsOverview;

            if (response == null) {
              return const SizedBox();
            }

            final data = response.data;

            final topSource = _getTopSource(
              feedPercentage: data.feedPercentage,
              searchPercentage: data.searchPercentage,
              profilePercentage: data.profilePercentage,
            );

            return RefreshIndicator(
              onRefresh: () {
                return controller.refreshPostViewsOverview(
                  postId: widget.postId,
                );
              },

              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 4),
                children: [
                  ViewsOverviewHeader(
                    onBack: () => Get.back(),
                    onCalendarTap: () {
                      // افتح date picker لاحقاً
                    },
                  ),

                  const SizedBox(height: 35),

                  TotalViewsCard(totalViews: data.totalViews),

                  const SizedBox(height: 30),

                  ViewsBySourceChart(
                    totalViews: data.totalViews,
                    feedPercentage: data.feedPercentage,
                    searchPercentage: data.searchPercentage,
                    profilePercentage: data.profilePercentage,
                  ),

                  const SizedBox(height: 8),

                  ViewsSourceCards(
                    feedCount: data.feedCount,
                    searchCount: data.searchCount,
                    profileCount: data.profileCount,
                    feedPercentage: data.feedPercentage,
                    searchPercentage: data.searchPercentage,
                    profilePercentage: data.profilePercentage,
                  ),

                  TopSourceInsightCard(
                    source: topSource.name,
                    percentage: topSource.percentage,
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _TopSource _getTopSource({
    required double feedPercentage,
    required double searchPercentage,
    required double profilePercentage,
  }) {
    if (feedPercentage >= searchPercentage &&
        feedPercentage >= profilePercentage) {
      return _TopSource(name: 'Feed', percentage: feedPercentage);
    }

    if (searchPercentage >= profilePercentage) {
      return _TopSource(name: 'Search', percentage: searchPercentage);
    }

    return _TopSource(name: 'Profile', percentage: profilePercentage);
  }
}

class _TopSource {
  final String name;
  final double percentage;

  const _TopSource({required this.name, required this.percentage});
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 18),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
