import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/get_grwoth_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import 'package:programmers_network_app/view/widget/Home/grwoth/growth_grid_widet.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/over_growth_card_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/priod_selector_widget.dart';

class GrowthPage extends StatefulWidget {
  const GrowthPage({super.key});

  @override
  State<GrowthPage> createState() => _GrowthPageState();
}

class _GrowthPageState extends State<GrowthPage> {
  late final GrowthController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(GrowthController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getGrowth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            size: 24,
            color: ColorConst.colorButton,
          ),
        ),

        title: const Row(
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedChartIncrease,
              size: 24,
              color: ColorConst.colorButton,
            ),
            SizedBox(width: 10),

            Text(
              'Growth Metrics',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),

        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const HugeIcon(
        //       icon: HugeIcons.strokeRoundedCalendar03,
        //       size: 23,
        //       color: Color(0xFF6D3DF5),
        //     ),
        //   ),

        //   const SizedBox(width: 8),
        // ],
      ),

      body: GetBuilder<GrowthController>(
        builder: (_) {
          if (controller.isLoading && controller.data == null) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFB8FF1A)),
            );
          }

          if (controller.errorMessage.value.isNotEmpty &&
              controller.data == null) {
            return _GrowthErrorWidget(
              message: controller.errorMessage.value,
              onRetry: () =>
                  controller.getGrowth(period: controller.currentPeriod),
            );
          }

          if (controller.data == null) {
            return const SizedBox.shrink();
          }

          final growth = controller.data!.growth;

          return RefreshIndicator(
            color: const Color(0xFFB8FF1A),
            backgroundColor: Colors.white,
            onRefresh: () =>
                controller.getGrowth(period: controller.currentPeriod),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
              children: [
                PeriodSelectorGrowth(controller: controller),

                const SizedBox(height: 20),

                OverallGrowthCard(
                  growth: growth.overall,
                  period: controller.data!.period,
                ),

                const SizedBox(height: 22),

                const Text(
                  'Growth Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),

                const SizedBox(height: 12),

                GrowthGrid(growth: growth),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GrowthErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _GrowthErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedAlert02,
                  size: 30,
                  color: Colors.redAccent,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8FF1A),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
