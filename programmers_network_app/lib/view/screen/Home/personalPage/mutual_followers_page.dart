import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/personalPage/mutualFollowers/mutual_followers_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/empty_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/mutual_card_widget.dart';

class MutualFollowersPage extends StatefulWidget {
  final int targetUserId;

  const MutualFollowersPage({super.key, required this.targetUserId});

  @override
  State<MutualFollowersPage> createState() => _MutualFollowersPageState();
}

class _MutualFollowersPageState extends State<MutualFollowersPage> {
  late final MutualFollowersController controller;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      MutualFollowersController(),
      tag: widget.targetUserId.toString(),
    );

    controller.fetchMutualFollowers(targetUserId: widget.targetUserId);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.loadMore(targetUserId: widget.targetUserId);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    Get.delete<MutualFollowersController>(tag: widget.targetUserId.toString());
    super.dispose();
  }

  Future<void> refreshData() async {
    await controller.refreshMutualFollowers(targetUserId: widget.targetUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        title: const Text(
          "Mutual Followers",
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.mutualFollowers.isEmpty) {
            return const FollowersEmptyWidget();
          }

          return ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount:
                controller.mutualFollowers.length +
                (controller.isLoadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.mutualFollowers.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final user = controller.mutualFollowers[index];

              return MutualCard(user: user);
            },
          );
        }),
      ),
    );
  }
}
