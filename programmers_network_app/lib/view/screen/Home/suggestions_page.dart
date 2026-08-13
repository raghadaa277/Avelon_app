import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:programmers_network_app/controller/Home/personalPage/profile_view_controller.dart';
import 'package:programmers_network_app/controller/Home/suggestions/suggestions_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/Home/suggestions_card_widget.dart';

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({super.key});

  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  late final SuggestionsController controller;
  late final ProfileViewController profileViewController;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    controller = Get.isRegistered<SuggestionsController>()
        ? Get.find<SuggestionsController>()
        : Get.put(SuggestionsController());

    profileViewController = Get.isRegistered<ProfileViewController>()
        ? Get.find<ProfileViewController>()
        : Get.put(ProfileViewController());

    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!scrollController.hasClients) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      controller.loadMore();
    }
  }

  Future<void> refreshData() async {
    await controller.refreshSuggestions();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,

      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: const Text(
          'Suggestions',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2),
        ),
      ),

      body: RefreshIndicator(
        color: const Color(0xffB8FF1A),
        backgroundColor: Colors.white,
        onRefresh: refreshData,

        child: Obx(() {
          if (controller.isLoading.value && controller.suggestions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xffB8FF1A)),
            );
          }

          if (controller.errorMessage.isNotEmpty &&
              controller.suggestions.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (controller.suggestions.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(
                  height: 500,
                  child: Center(
                    child: Text(
                      'No suggestions available',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),

            itemCount:
                controller.suggestions.length +
                (controller.isLoadingMore.value ? 1 : 0),

            itemBuilder: (context, index) {
              if (index == controller.suggestions.length) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xffB8FF1A)),
                  ),
                );
              }

              final suggestion = controller.suggestions[index];

              return SuggestionUserCard(
                suggestion: suggestion,
                profileViewController: profileViewController,
              );
            },
          );
        }),
      ),
    );
  }
}
