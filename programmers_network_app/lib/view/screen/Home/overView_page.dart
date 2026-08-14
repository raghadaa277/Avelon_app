import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/get_grwoth_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import 'package:programmers_network_app/view/widget/Home/overview/overview_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/overview/overview_filter_widget.dart';
import 'package:programmers_network_app/view/widget/Home/overview/overview_matric_grid_widget.dart';
import 'package:programmers_network_app/view/widget/Home/overview/overview_section_header_widget.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late final GrowthController controller;

  static const Color primaryColor = Color.fromARGB(255, 206, 241, 130);

  @override
  void initState() {
    super.initState();

    controller = Get.isRegistered<GrowthController>()
        ? Get.find<GrowthController>()
        : Get.put(GrowthController());

    controller.getOverview(type: 'all');
  }

  Future<void> _selectStartDate() async {
    if (controller.currentType != 'custom') return;

    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: controller.currentStartDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    controller.currentStartDate = picked;

    if (controller.currentEndDate != null &&
        picked.isAfter(controller.currentEndDate!)) {
      controller.currentEndDate = null;
    }

    controller.update();
  }

  Future<void> _selectEndDate() async {
    if (controller.currentType != 'custom') return;

    final now = DateTime.now();

    final firstDate = controller.currentStartDate ?? DateTime(2000);

    final picked = await showDatePicker(
      context: context,
      initialDate: controller.currentEndDate ?? now,
      firstDate: firstDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    controller.currentEndDate = picked;

    controller.update();

    if (controller.currentStartDate != null) {
      await controller.getOverview(
        type: 'custom',
        startDate: controller.currentStartDate,
        endDate: controller.currentEndDate,
      );
    }
  }

  Future<void> _selectCustom() async {
    controller.currentType = 'custom';
    controller.currentStartDate = null;
    controller.currentEndDate = null;

    controller.overview = null;

    controller.update();
  }

  Future<void> _selectAll() async {
    await controller.getOverview(type: 'all');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,

      body: SafeArea(
        child: GetBuilder<GrowthController>(
          builder: (controller) {
            return RefreshIndicator(
              color: primaryColor,
              onRefresh: controller.refreshOverview,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: OverviewHeaderWidget(onBack: () => Get.back()),
                  ),

                  SliverToBoxAdapter(
                    child: OverviewFilterWidget(
                      isCustom: controller.currentType == 'custom',

                      startDate: controller.currentStartDate,

                      endDate: controller.currentEndDate,

                      onAllSelected: _selectAll,

                      onCustomSelected: _selectCustom,

                      onStartDate: _selectStartDate,

                      onEndDate: _selectEndDate,
                    ),
                  ),

                  if (controller.isLoading)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      ),
                    )
                  else if (controller.errorMessage.value.isNotEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _ErrorWidget(
                        message: controller.errorMessage.value,
                        onRetry: controller.refreshOverview,
                      ),
                    )
                  else if (controller.overview == null)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: Text('No overview data available')),
                    )
                  else ...[
                    SliverToBoxAdapter(
                      child: OverviewSectionHeaderWidget(
                        period: controller.currentType,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: OverviewMetricsGridWidget(
                        data: controller.overview!.data,
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 45,
              color: Colors.pink,
            ),

            const SizedBox(height: 12),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 206, 241, 130),
                foregroundColor: Colors.black,
                elevation: 0,
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
