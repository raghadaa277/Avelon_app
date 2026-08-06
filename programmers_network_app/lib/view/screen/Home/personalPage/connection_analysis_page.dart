import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/personalPage/mutualFollowers/mutual_followers_controller.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/common_card_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/connection_card_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/connection_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/meaning_card_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/mutual_followers_crad_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_views_card_widget.dart';

class ConnectionAnalysisPage extends StatefulWidget {
  final int targetUserId;

  const ConnectionAnalysisPage({super.key, required this.targetUserId});

  @override
  State<ConnectionAnalysisPage> createState() => _ConnectionAnalysisPageState();
}

class _ConnectionAnalysisPageState extends State<ConnectionAnalysisPage> {
  final controller = Get.put(MutualFollowersController());

  @override
  void initState() {
    super.initState();

    controller.fetchConnectionAnalysis(targetUserId: widget.targetUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Obx(() {
          final data = controller.connectionAnalysis.value?.data;

          if (controller.isLoading.value || data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                ConnectionHeaderWidget(),

                const SizedBox(height: 25),

                OverallConnectionCard(
                  percentage: data.connection.percentage,
                  status: data.connection.status,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: MutualFollowersCard(
                        count: data.mutualFollowers.count,
                        percentage: data.mutualFollowers.percentage,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: CommonInterestCard(
                        count: data.interests.commonCount,
                        percentage: data.interests.percentage,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                ProfileViewsCard(data: data.profileViews),

                const SizedBox(height: 20),

                const ConnectionMeaningCard(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
