import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:programmers_network_app/controller/Home/home_page_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/profile_view_controller.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/controller/Home/reactions_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import 'package:programmers_network_app/core/const/routesPage.dart';

import 'package:programmers_network_app/view/widget/Home/comment_widget.dart';
import 'package:programmers_network_app/view/widget/Home/custom_app_bar.dart';
import 'package:programmers_network_app/view/widget/Home/custom_bottom_nav_bar.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_viewed.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController controller = Get.put(HomePageController());

  final EditPostController editPostController = Get.put(EditPostController());

  final ReactionsController reactionsController = Get.put(
    ReactionsController(),
  );
  final FocusNode _FocusNode = FocusNode();

  late ProfileViewController profileViewController;

  final ScrollController _scrollController = ScrollController();

  static const Color limeColor = Color(0xffB8FF1A);

  @override
  void initState() {
    super.initState();

    controller.getFeed(refresh: true);

    _scrollController.addListener(_onScroll);

    profileViewController = Get.put(ProfileViewController());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 250) {
      controller.loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,

      appBar: const CustomAppBar(),

      body: SafeArea(
        child: GetBuilder<HomePageController>(
          init: controller,
          builder: (controller) {
            return _buildBody(controller);
          },
        ),
      ),

      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildBody(HomePageController controller) {
    if (controller.isLoadingHome && controller.posts.isEmpty) {
      return const _HomeInitialLoading();
    }

    if (controller.errorMessage.value.isNotEmpty && controller.posts.isEmpty) {
      return _HomeError(
        message: controller.errorMessage.value,
        onRetry: () {
          controller.getFeed(refresh: true);
        },
      );
    }

    if (controller.posts.isEmpty) {
      return const _HomeEmptyState();
    }

    return RefreshIndicator(
      color: limeColor,
      backgroundColor: Colors.white,

      strokeWidth: 2.5,

      onRefresh: () async {
        await controller.getFeed(refresh: true);
      },

      child: CustomScrollView(
        controller: _scrollController,

        physics: const AlwaysScrollableScrollPhysics(),

        slivers: [
          SliverToBoxAdapter(child: _buildFeedHeader(controller)),

          SliverPadding(
            padding: const EdgeInsets.only(top: 4, bottom: 20),

            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= controller.posts.length) {
                    return const _LoadMoreIndicator();
                  }

                  final post = controller.posts[index];

                  return PostViewTrackerWrapper(
                    source: "feed",

                    post: post,

                    onSeen: () {
                      if (post.feedId != null && post.feedId! > 0) {
                        profileViewController.feedSeen(post.feedId!);
                      }
                    },

                    child: PostCardWidget(
                      key: ValueKey(post.id),

                      post: post,

                      media: post.postMedia,

                      onUserTap: () {
                        Get.toNamed(
                          AppRoute.otherUserProfilePage,
                          arguments: post.user.id,
                        );
                      },

                      onLike: () async {
                        _FocusNode.unfocus();
                        controller.updateReaction(
                          postId: post.id,
                          reaction: "like",
                        );

                        final success = await reactionsController.reactions(
                          targetUserId: post.user.id,
                          postId: post.id,
                          type: "like",
                        );
                        if (!success) {
                          controller.getFeed(refresh: true);
                        }
                      },

                      onDislike: () async {
                        _FocusNode.unfocus();
                        controller.updateReaction(
                          postId: post.id,
                          reaction: "dislike",
                        );

                        final success = await reactionsController.reactions(
                          targetUserId: post.user.id,
                          postId: post.id,
                          type: "dislike",
                        );
                        if (!success) {
                          controller.getFeed(refresh: true);
                        }
                      },

                      onComment: () {
                        _FocusNode.unfocus();
                        showCommentsPage(
                          context,
                          postId: post.id,
                          targetUserId: post.user.id,
                        );
                      },

                      onShare: () {},

                      onSave: () async {
                        _FocusNode.unfocus();
                        final post = controller.posts[index];
                        await editPostController.savePost(
                          targetUserId: post.user.id,
                          postId: post.id,
                        );
                      },

                      onTap: () {},

                      onWhySeeing: () {
                        if (post.feedId != null && post.feedId! > 0) {
                          controller.getSource(feedId: post.feedId!);
                        }
                      },
                    ),
                  );
                },

                childCount:
                    controller.posts.length +
                    (controller.isLoadingMoreHome ? 1 : 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedHeader(HomePageController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 10),

      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,

            decoration: BoxDecoration(
              color: limeColor.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),

            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedNews01,
              color: Color(0xff78A800),
              size: 23,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'For You',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Discover what your network is sharing',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),

            decoration: BoxDecoration(
              color: const Color(0xffF4FBE5),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,

                  decoration: const BoxDecoration(
                    color: Color(0xff8BC400),
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 5),

                Text(
                  'LIVE',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey.shade700,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeInitialLoading extends StatelessWidget {
  const _HomeInitialLoading();

  static const Color limeColor = Color(0xffB8FF1A);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              color: limeColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),

            padding: const EdgeInsets.all(15),

            child: const CircularProgressIndicator(
              strokeWidth: 3,

              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff8FBE00)),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Loading your feed',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Finding something interesting for you...',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

class _LoadMoreIndicator extends StatelessWidget {
  const _LoadMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),

      child: Center(
        child: Container(
          width: 42,
          height: 42,

          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: const Color(0xffB8FF1A).withOpacity(0.15),
            shape: BoxShape.circle,
          ),

          child: const CircularProgressIndicator(
            strokeWidth: 2.5,

            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff8FBE00)),
          ),
        ),
      ),
    );
  }
}

class _HomeEmptyState extends StatelessWidget {
  const _HomeEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 75,

              decoration: BoxDecoration(
                color: const Color(0xffB8FF1A).withOpacity(0.15),
                shape: BoxShape.circle,
              ),

              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedNews01,
                size: 34,
                color: Color(0xff8FBE00),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Your feed is quiet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 8),

            Text(
              'Follow developers and connect with your network '
              'to discover new posts here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _HomeError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

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

              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedAlert02,
                color: Colors.redAccent,
                size: 30,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Something went wrong',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 7),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),

            const SizedBox(height: 18),

            ElevatedButton.icon(
              onPressed: onRetry,

              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedRefresh,
                size: 18,
              ),

              label: const Text('Try again'),

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffB8FF1A),
                foregroundColor: Colors.black,

                elevation: 0,

                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 11,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
