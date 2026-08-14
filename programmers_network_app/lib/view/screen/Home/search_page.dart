import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/controller/Home/reactions_controller.dart';
import 'package:programmers_network_app/controller/Home/search_controller.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/view/widget/Home/comment_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/empty_search_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/history_search_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/loading_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_viewed.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_result_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_tap_item_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_top_bar_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_user_title_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_card_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchPageController controller;
  final ReactionsController reactionsController = Get.put(
    ReactionsController(),
  );

  final EditPostController editPostController = Get.put(EditPostController());
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  int _selectedTabIndex = 0;
  Timer? _debounce;

  bool get _isUsersTab => _selectedTabIndex == 0;

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
    _searchFocusNode.dispose();
    _scrollController.dispose();

    Get.delete<SearchPageController>(force: true);
    Get.delete<ReactionsController>(force: true);

    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_isUsersTab) {
        controller.loadMore();
      } else {
        controller.loadMorePosts();
      }
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

    _searchFocusNode.unfocus();

    if (_isUsersTab) {
      controller.search(
        user: SearchTabsWidget.tabs[_selectedTabIndex].apiType,
        search: query.trim(),
        refresh: true,
      );
    } else {
      controller.searchPost(
        type: SearchTabsWidget.tabs[_selectedTabIndex].apiType,
        search: query.trim(),
        refresh: true,
      );
    }
  }

  void _onTabChanged(int index) {
    _searchFocusNode.unfocus();
    setState(() => _selectedTabIndex = index);
    _runSearch(_searchTextController.text);
  }

  void _onClearSearch() {
    setState(() => _searchTextController.clear());
    controller.users.clear();
    controller.posts.clear();
    controller.hasSearchedPosts = false;
    controller.update();
  }

  int get _resultsCount =>
      _isUsersTab ? controller.users.length : controller.posts.length;

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
                  focusNode: _searchFocusNode,
                  onChanged: _onSearchChanged,
                  onClear: _onClearSearch,
                ),
                SearchTabsWidget(
                  selectedIndex: _selectedTabIndex,
                  onTabSelected: _onTabChanged,
                ),
                SearchResultsHeaderWidget(
                  title: SearchTabsWidget.tabs[_selectedTabIndex].label,
                  total: _resultsCount,
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
    if (_searchTextController.text.trim().isEmpty) {
      return HistorySearchWidget(
        searchController: _searchTextController,
        searchType: SearchTabsWidget.tabs[_selectedTabIndex].apiType,
      );
    }

    return _isUsersTab
        ? _buildUsersBody(controller)
        : _buildPostsBody(controller);
  }

  Widget _buildUsersBody(SearchPageController controller) {
    if (controller.isLoading && controller.users.isEmpty) {
      return const Center(child: SearchLoadingWidget());
    }

    if (controller.errorMessage.value.isNotEmpty && controller.users.isEmpty) {
      return Center(child: Text(controller.errorMessage.value));
    }

    if (!controller.hasSearchedPosts) {
      return _emptyState("Search developers or problems...");
    }

    if (controller.isLoadingPosts) {
      return const Center(child: SearchLoadingWidget());
    }

    if (controller.errorMessage.value.isNotEmpty && controller.posts.isEmpty) {
      return Center(child: Text(controller.errorMessage.value));
    }

    if (controller.posts.isEmpty) {
      return const EmptySearchWidget();
    }

    return RefreshIndicator(
      onRefresh: () => controller.search(
        user: SearchTabsWidget.tabs[_selectedTabIndex].apiType,
        search: _searchTextController.text.trim(),
        refresh: true,
      ),
      child: ListView.separated(
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
              Get.toNamed(AppRoute.otherUserProfilePage, arguments: user.id);
            },
          );
        },
      ),
    );
  }

  Widget _buildPostsBody(SearchPageController controller) {
    if (!controller.hasSearchedPosts) {
      return _emptyState("Search developers or problems...");
    }

    if (controller.isLoadingPosts) {
      return const Center(child: SearchLoadingWidget());
    }

    if (controller.errorMessage.value.isNotEmpty && controller.posts.isEmpty) {
      return Center(child: Text(controller.errorMessage.value));
    }

    if (controller.posts.isEmpty) {
      return const EmptySearchWidget();
    }

    return RefreshIndicator(
      onRefresh: () => controller.searchPost(
        type: SearchTabsWidget.tabs[_selectedTabIndex].apiType,
        search: _searchTextController.text.trim(),
        refresh: true,
      ),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount:
            controller.posts.length + (controller.isLoadingMorePosts ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= controller.posts.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final post = controller.posts[index];

          return PostViewTrackerWrapper(
            source: "search",
            post: post,
            isOwner: true,
            child: PostCardWidget(
              key: ValueKey(post.id),
              post: post,
              media: post.postMedia,
              onUserTap: () {
                _searchFocusNode.unfocus();
                Get.toNamed(
                  AppRoute.otherUserProfilePage,
                  arguments: post.user.id,
                );
              },
              onLike: () async {
                _searchFocusNode.unfocus();
                controller.updateReaction(postId: post.id, reaction: "like");

                final success = await reactionsController.reactions(
                  targetUserId: post.user.id,
                  postId: post.id,
                  type: "like",
                );

                if (!success) {
                  controller.searchPost(
                    type: controller.currentPostType!,
                    search: controller.currentPostSearch!,
                    refresh: true,
                  );
                }
              },
              onDislike: () async {
                _searchFocusNode.unfocus();
                controller.updateReaction(postId: post.id, reaction: "dislike");

                final success = await reactionsController.reactions(
                  targetUserId: post.user.id,
                  postId: post.id,
                  type: "dislike",
                );

                if (!success) {
                  controller.searchPost(
                    type: controller.currentPostType!,
                    search: controller.currentPostSearch!,
                    refresh: true,
                  );
                }
              },
              onComment: () {
                _searchFocusNode.unfocus();
                showCommentsPage(
                  context,
                  postId: post.id,
                  targetUserId: post.user.id,
                );
              },
              onShare: () {},
              onSave: () async {
                _searchFocusNode.unfocus();
                final post = controller.posts[index];
                await editPostController.savePost(
                  targetUserId: post.user.id,
                  postId: post.id,
                );
              },
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _emptyState(String message) {
    return Center(
      child: Text(message, style: TextStyle(color: Colors.grey.shade500)),
    );
  }
}
