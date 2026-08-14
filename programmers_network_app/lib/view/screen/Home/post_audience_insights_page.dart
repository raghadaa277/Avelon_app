import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:programmers_network_app/controller/Home/get_grwoth_controller.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/audience/audience_balance_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/audience/audience_breakdown_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/audience/audience_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/audience/audience_status_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/audience/audience_total_views_card_widget.dart';

class PostAudienceInsightsPage extends StatefulWidget {
  final int postId;

  const PostAudienceInsightsPage({super.key, required this.postId});

  @override
  State<PostAudienceInsightsPage> createState() =>
      _PostAudienceInsightsPageState();
}

class _PostAudienceInsightsPageState extends State<PostAudienceInsightsPage> {
  late final GrowthController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.isRegistered<GrowthController>()
        ? Get.find<GrowthController>()
        : Get.put(GrowthController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPostAudience(postId: widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFDFC),

      body: SafeArea(
        child: GetBuilder<GrowthController>(
          builder: (controller) {
            return RefreshIndicator(
              color: const Color(0xFF7BBE32),

              onRefresh: () {
                return controller.refreshPostAudience(postId: widget.postId);
              },

              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),

                slivers: [
                  SliverToBoxAdapter(
                    child: AudienceHeaderWidget(
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),

                  if (controller.isLoading)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF7BBE32),
                        ),
                      ),
                    )
                  else if (controller.postAudience == null)
                    SliverFillRemaining(
                      hasScrollBody: false,

                      child: _AudienceErrorWidget(
                        message: controller.errorMessage.value.isEmpty
                            ? 'Something went wrong.'
                            : controller.errorMessage.value,

                        onRetry: () {
                          controller.getPostAudience(postId: widget.postId);
                        },
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),

                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          AudienceTotalViewsCard(
                            followersViews:
                                controller.postAudience!.followersViews,

                            nonFollowersViews:
                                controller.postAudience!.nonFollowersViews,
                          ),

                          const SizedBox(height: 24),

                          AudienceBreakdownWidget(
                            data: controller.postAudience!,
                          ),

                          const SizedBox(height: 18),

                          AudienceStatCardsWidget(
                            data: controller.postAudience!,
                          ),

                          const SizedBox(height: 18),

                          AudienceBalanceWidget(data: controller.postAudience!),
                        ]),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AudienceErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _AudienceErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HugeIcon(
              icon: HugeIcons.strokeRoundedAnalytics01,
              size: 50,
              color: Color(0xFF7BBE32),
            ),

            const SizedBox(height: 14),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),

            const SizedBox(height: 18),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8FF1A),
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
