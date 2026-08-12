import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/personalPage/get_target_user_skills_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/empty_status_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/error_status_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/loading_status_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/skills_content_widget.dart';

class TargetUserSkillsView extends StatefulWidget {
  final int targetUserId;

  const TargetUserSkillsView({super.key, required this.targetUserId});

  @override
  State<TargetUserSkillsView> createState() => _TargetUserSkillsViewState();
}

class _TargetUserSkillsViewState extends State<TargetUserSkillsView> {
  late final GetTargetUserSkillsController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      GetTargetUserSkillsController(),
      tag: widget.targetUserId.toString(),
    );

    controller.getSkills(targetUserId: widget.targetUserId);
  }

  Future<void> _refreshProfile() async {
    await controller.getSkills(targetUserId: widget.targetUserId);
  }

  @override
  void dispose() {
    Get.delete<GetTargetUserSkillsController>(
      tag: widget.targetUserId.toString(),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      body: RefreshIndicator(
        color: ColorConst.colorButton,
        backgroundColor: Colors.white,
        onRefresh: _refreshProfile,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const LoadingState();
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return ErrorState(
              message: controller.errorMessage.value,
              onRetry: () {
                controller.getSkills(targetUserId: widget.targetUserId);
              },
            );
          }

          if (controller.userSkills.isEmpty) {
            return const EmptyState();
          }

          return SkillsContent(skills: controller.userSkills);
        }),
      ),
    );
  }
}
