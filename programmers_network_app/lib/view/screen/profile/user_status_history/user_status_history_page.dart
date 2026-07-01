import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/profile/user_status_history_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/current_status_card.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/status_history_section.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/status_summary_card.dart';

class UserStatusHistoryScreen extends StatelessWidget {
  const UserStatusHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserStatusHistoryController>(
      init: UserStatusHistoryController()..getUserStatus(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConst.colorBackGroung,
          appBar: AppBar(
            backgroundColor: ColorConst.colorBackGroung,
            elevation: 0,
            centerTitle: true,
            scrolledUnderElevation: 0,
            leading: GestureDetector(
              onTap: Get.back,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: cardColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            title: const Text(
              "Account Status",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),

          body: Builder(
            builder: (_) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: accent),
                );
              }

              if (controller.errorMessage != null) {
                return Center(child: Text(controller.errorMessage!));
              }

              if (controller.userStatusHistoryModel == null) {
                return const SizedBox();
              }

              final model = controller.userStatusHistoryModel!;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                child: Column(
                  children: [
                    CurrentStatusCard(current: model.data.currentStatus),

                    const SizedBox(height: 16),

                    StatusSummaryCard(summary: model.data.statusSummary),

                    const SizedBox(height: 16),

                    StatusHistorySection(histories: model.data.statusHistories),

                    const SizedBox(height: 24),

                    const Text(
                      "All times are displayed in your local timezone.",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
