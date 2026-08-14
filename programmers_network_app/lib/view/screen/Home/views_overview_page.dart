import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/get_grwoth_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/Home/grwothPost/overView_stat_card_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwothPost/overview_error_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwothPost/overview_header_post_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwothPost/overview_insight_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwothPost/overview_loading_widget.dart';

class ViewsOverviewPage extends StatefulWidget {
  final int postId;

  const ViewsOverviewPage({super.key, required this.postId});

  @override
  State<ViewsOverviewPage> createState() => _ViewsOverviewPageState();
}

class _ViewsOverviewPageState extends State<ViewsOverviewPage> {
  late final GrowthController controller;

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<GrowthController>()) {
      controller = Get.find<GrowthController>();
    } else {
      controller = Get.put(GrowthController());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getOverviewPost(postId: widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    const lime = Color.fromARGB(255, 206, 241, 130);
    const pink = Color(0xFFF7A8C4);

    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      body: SafeArea(
        child: GetBuilder<GrowthController>(
          builder: (controller) {
            return RefreshIndicator(
              color: lime,
              onRefresh: () {
                return controller.refreshOverviewPost(postId: widget.postId);
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: OverviewHeaderPostWidget(
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),

                  if (controller.isLoading)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: OverviewLoadingWidget(),
                    )
                  else if (controller.overviewPost == null)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: OverviewErrorWidget(
                        message: controller.errorMessage.value.isEmpty
                            ? 'Something went wrong.'
                            : controller.errorMessage.value,
                        onRetry: () {
                          controller.getOverviewPost(postId: widget.postId);
                        },
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          OverviewStatCardWidget(
                            title: 'Unique Viewers',
                            value: controller.overviewPost!.data.uniqueViewers
                                .toString(),
                            description: 'Users who viewed your content',
                            leadingIcon: HugeIcons.strokeRoundedUserGroup,
                            trailingIcon: HugeIcons.strokeRoundedAnalyticsUp,
                            accentColor: Colors.pinkAccent,
                            iconBackgroundColor: pink.withOpacity(.16),
                          ),

                          OverviewStatCardWidget(
                            title: 'Total Views',
                            value: controller.overviewPost!.data.totalViews
                                .toString(),
                            description: 'Total number of views',
                            leadingIcon: HugeIcons.strokeRoundedView,
                            trailingIcon: HugeIcons.strokeRoundedChartHistogram,
                            accentColor: const Color(0xFF7BBE32),
                            iconBackgroundColor: lime.withOpacity(.23),
                          ),

                          OverviewStatCardWidget(
                            title: 'Average Views Per User',
                            value: controller
                                .overviewPost!
                                .data
                                .averageViewsPerUser
                                .toStringAsFixed(4),
                            description: 'Average views per unique user',
                            leadingIcon: HugeIcons.strokeRoundedUserMultiple,
                            trailingIcon: HugeIcons.strokeRoundedPieChart,
                            accentColor: const Color(0xFFEF8EAD),
                            iconBackgroundColor: pink.withOpacity(.15),
                          ),

                          const SizedBox(height: 2),

                          OverviewInsightCardWidget(
                            averageViews: controller
                                .overviewPost!
                                .data
                                .averageViewsPerUser,
                          ),
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
