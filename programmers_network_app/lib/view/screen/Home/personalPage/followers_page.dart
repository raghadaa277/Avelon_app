import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/personalPage/follower/followe_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/empty_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/follow_user_card_widget.dart';

class FollowersPage extends StatefulWidget {
  final int targetUserId;
  final String type;

  const FollowersPage({
    super.key,
    required this.targetUserId,
    required this.type,
  });

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  final FolloweController controller = Get.put(FolloweController());

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.fetchFollowers(
      targetUserId: widget.targetUserId,
      type: widget.type,
      refresh: true,
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  Future<void> refreshData() async {
    await controller.fetchFollowers(
      targetUserId: widget.targetUserId,
      type: widget.type,
      refresh: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        title: Text(
          widget.type == "followers" ? "Followers" : "Following",
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: refreshData,

        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.followers.isEmpty) {
            return const FollowersEmptyWidget();
          }

          return ListView.builder(
            controller: scrollController,

            physics: const AlwaysScrollableScrollPhysics(),

            itemCount:
                controller.followers.length +
                (controller.isLoadingMore.value ? 1 : 0),

            itemBuilder: (context, index) {
              if (index == controller.followers.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final user = controller.followers[index];

              return FollowUserCard(user: user);
            },
          );
        }),
      ),
    );
  }
}
