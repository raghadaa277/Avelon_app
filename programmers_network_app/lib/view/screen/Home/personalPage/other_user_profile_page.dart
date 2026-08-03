import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/personalPage/closeFriends/close_friends_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/follower/followe_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/get_target_user_count_controller.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_about_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_action_buttons_widget.dart';

import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_theme_widget.dart';

class OtherUserProfilePage extends StatefulWidget {
  final int targetUserId;
  const OtherUserProfilePage({super.key, required this.targetUserId});

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage>
    with SingleTickerProviderStateMixin {
  final FolloweController followController = Get.put(FolloweController());
  final GetTargetUserCountController controller = Get.put(
    GetTargetUserCountController(),
  );
  final CloseFriendsController closeFriendController = Get.put(
    CloseFriendsController(),
  );
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    controller.fetchOtherUserProfile(targetUserId: widget.targetUserId);
    controller.fetchTargetUserCount(targetUserId: widget.targetUserId);

    ever(controller.userProfile, (profile) {
      if (profile != null) {
        followController.setFollowStatus(profile.followStatus);
        closeFriendController.setCloseFriend(profile.isCloseFriend);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileTheme.pageBg,
      appBar: AppBar(
        backgroundColor: ProfileTheme.pageBg,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: ProfileTheme.textDark),
        title: const Text(
          'AVELON',
          style: TextStyle(
            color: ProfileTheme.textDark,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: ProfileTheme.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.userProfile.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.userProfile.value == null) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final profile = controller.userProfile.value;

        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Obx(() {
                  return ProfileHeaderWidget(
                    avatarUrl: controller.avatarFullUrl,
                    fullName: controller.fullName,
                    username: controller.username,
                    specialization: profile?.specialization,
                    city: controller.city,
                    country: controller.country,
                    bio: controller.bio,
                    postsCount: controller.postsCount,
                    followersCount: controller.followersCount,
                    followingCount: controller.followingsCount,

                    followStatus: followController.followStatus.value,

                    isCloseFriend:
                        controller.userProfile.value?.isCloseFriend ?? false,

                    isMuted: controller.userProfile.value?.isMuted ?? false,

                    isFlagged: controller.userProfile.value?.isFlagged ?? false,

                    isCloseFriendOf:
                        controller.userProfile.value?.isCloseFriendOf ?? false,

                    isMutedBy: controller.userProfile.value?.isMutedBy ?? false,

                    isFlaggedBy:
                        controller.userProfile.value?.isFlaggedBy ?? false,

                    onFollow: () async {
                      final action = await followController.toggleFollowing(
                        targetUserId: widget.targetUserId,
                      );
                      if (action == FollowAction.followed) {
                        controller.increaseFollowersCount();
                        controller.setFollowStatus(
                          followController.followStatus.value,
                        );
                      }
                    },

                    onUnfollow: () async {
                      final action = await followController.toggleFollowing(
                        targetUserId: widget.targetUserId,
                      );

                      if (action == FollowAction.unfollowed) {
                        controller.decreaseFollowersCount();
                        controller.setFollowStatus(
                          followController.followStatus.value,
                        );
                      }
                    },

                    onMessage: () {},

                    onShare: () {},
                    onMenuSelected: (action) async {
                      switch (action) {
                        case ProfileMenuAction.toggleCloseFriend:
                          final action = await closeFriendController
                              .toggleCloseFriend(
                                targetUserId: widget.targetUserId,
                                currentState: controller.isClosed,
                              );

                          if (action == CloseFriendAction.added) {
                            controller.setCloseFriend(true);
                          }

                          if (action == CloseFriendAction.removed) {
                            controller.setCloseFriend(false);
                          }

                          break;

                        case ProfileMenuAction.toggleMute:
                          break;

                        case ProfileMenuAction.report:
                          break;
                      }
                    },
                  );
                }),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: ProfileTheme.primaryGreenDark,
                  unselectedLabelColor: ProfileTheme.textGrey,
                  indicatorColor: ProfileTheme.primaryGreen,
                  tabs: const [
                    Tab(text: 'Posts'),
                    Tab(text: 'About'),
                    Tab(text: 'Skills'),
                    Tab(text: 'Highlights'),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              const Center(child: Text('Posts grid goes here')),
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ProfileAboutSectionWidget(
                  educationStatus: profile?.educationStatus,
                  university: profile?.university,
                  major: profile?.major,
                  studyYear: profile?.studyYear,
                  country: profile?.country,
                  city: profile?.city,
                  specialization: profile?.specialization,
                  jobTitle: profile?.jobTitle,
                  company: profile?.company,
                  experienceYears: profile?.experienceYears,
                  githubUrl: profile?.githubUrl,
                  linkedinUrl: profile?.linkedinUrl,
                  isCloseFriend: profile?.isCloseFriend ?? false,
                  isMuted: profile?.isMuted ?? false,
                  isFlagged: profile?.isFlagged ?? false,
                  onOpenLink: (url) {
                    // TODO: launch url_launcher with `url`.
                  },
                ),
              ),
              const Center(child: Text('Skills go here')),
              const Center(child: Text('Highlights go here')),
            ],
          ),
        );
      }),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: ProfileTheme.pageBg, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}
