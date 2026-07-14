import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/search_controller.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_result_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_tap_item_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_top_bar_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_user_title_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchPageController controller;

  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int _selectedTabIndex = 0;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SearchPageController());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchTextController.dispose();
    _scrollController.dispose();

    Get.delete<SearchPageController>(force: true);

    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMore();
    }
  }

  void _onSearchChanged(String value) {
    setState(() {});
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _runSearch(value);
    });
  }

  void _runSearch(String query) {
    if (query.trim().isEmpty) return;
    controller.search(
      user: SearchTabsWidget.tabs[_selectedTabIndex].apiType,
      search: query.trim(),
      refresh: true,
    );
  }

  void _onTabChanged(int index) {
    setState(() => _selectedTabIndex = index);
    _runSearch(_searchTextController.text);
  }

  void _onClearSearch() {
    setState(() => _searchTextController.clear());
    controller.users.clear();
    controller.update();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xffF7F9F4),
          body: SafeArea(
            child: Column(
              children: [
                SearchTopBarWidget(
                  textController: _searchTextController,
                  onChanged: _onSearchChanged,
                  onClear: _onClearSearch,
                ),
                SearchTabsWidget(
                  selectedIndex: _selectedTabIndex,
                  onTabSelected: _onTabChanged,
                ),
                SearchResultsHeaderWidget(
                  title: SearchTabsWidget.tabs[_selectedTabIndex].label,
                  total: controller.users.length,
                ),
                Expanded(child: _buildBody(controller)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(SearchPageController controller) {
    if (controller.isLoading && controller.users.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage.value.isNotEmpty && controller.users.isEmpty) {
      return Center(child: Text(controller.errorMessage.value));
    }

    if (controller.users.isEmpty) {
      return Center(
        child: Text(
          _searchTextController.text.isEmpty
              ? "Search developers or problems..."
              : "No result found",
          style: TextStyle(color: Colors.grey.shade500),
        ),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: controller.users.length + (controller.isLoadingMore ? 1 : 0),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index >= controller.users.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final user = controller.users[index];
        return SearchUserTileWidget(
          user: user,
          onTap: () {
            // Get.toNamed(AppRoute.userProfilePage, arguments: user.id);
          },
        );
      },
    );
  }
}
