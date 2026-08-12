import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/personalPage/block/block_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/closeFriends/close_friends_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/follower/followe_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/get_target_user_count_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/mute/mute_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/mutualFollowers/mutual_followers_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/profile_view_controller.dart';
import 'package:programmers_network_app/controller/Home/personalPage/user%20Flag/user_flag_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/screen/Home/personalPage/connection_analysis_page.dart';
import 'package:programmers_network_app/view/screen/Home/personalPage/followers_page.dart';
import 'package:programmers_network_app/view/screen/Home/personalPage/mutual_followers_page.dart';
import 'package:programmers_network_app/view/screen/Home/personalPage/report_page.dart';
import 'package:programmers_network_app/view/screen/Home/personalPage/target_user_skills_view_page.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/other_user_post_tap_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_about_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_action_buttons_widget.dart';

import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_theme_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/setting_button_widget.dart';

class OtherUserProfilePage extends StatefulWidget {
  final int targetUserId;
  const OtherUserProfilePage({super.key, required this.targetUserId});

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage>
    with SingleTickerProviderStateMixin {
  late final FolloweController followController;
  late final GetTargetUserCountController controller;
  late final CloseFriendsController closeFriendController;
  late final MuteController muteController;
  late final BlockController blockController;
  late final TabController _tabController;

  late final ProfileViewController profileViewController;
  late final MutualFollowersController mutualFollowers;

  @override
  void initState() {
    super.initState();

    followController = Get.put(FolloweController());

    controller = Get.put(
      GetTargetUserCountController(),
      tag: widget.targetUserId.toString(),
    );

    closeFriendController = Get.put(CloseFriendsController());

    profileViewController = Get.put(ProfileViewController());

    muteController = Get.put(MuteController());

    blockController = Get.put(BlockController());

    // mutualFollowers = Get.put(MutualFollowersController());

    Get.put(UserFlagController());

    _tabController = TabController(length: 4, vsync: this);

    controller.fetchOtherUserProfile(targetUserId: widget.targetUserId);

    controller.fetchTargetUserCount(targetUserId: widget.targetUserId);

    profileViewController.recordProfileView(widget.targetUserId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ever(controller.userProfile, (profile) {
        if (profile != null) {
          followController.setFollowStatus(profile.followStatus);

          closeFriendController.setCloseFriend(profile.isCloseFriend);

          muteController.setMuteStatus(profile.isMuted);

          if (profile.isBlockedBy) {
            blockController.blockedUserIds.add(widget.targetUserId);
          } else {
            blockController.blockedUserIds.remove(widget.targetUserId);
          }
        }
      });
    });
  }

  Future<void> _refreshProfile() async {
    await Future.wait([
      controller.fetchOtherUserProfile(targetUserId: widget.targetUserId),
      controller.fetchTargetUserCount(targetUserId: widget.targetUserId),
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: ProfileTheme.textDark),
        title: Text(
          'A V E L O N',
          style: TextStyle(
            color: ColorConst.colorApp,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        actions: [
          Obx(
            () => SettingButtonWidget(
              isCloseFriend:
                  controller.userProfile.value?.isCloseFriend ?? false,
              isMuted: controller.userProfile.value?.isMuted ?? false,
              isBlocked: blockController.isBlocked(widget.targetUserId),
              onSelected: (action) async {
                switch (action) {
                  case SettingAction.closeFriend:
                    final result = await closeFriendController
                        .toggleCloseFriend(
                          targetUserId: widget.targetUserId,
                          currentState:
                              controller.userProfile.value?.isCloseFriend ??
                              false,
                        );
                    if (result == CloseFriendAction.added) {
                      controller.setCloseFriend(true);
                    } else if (result == CloseFriendAction.removed) {
                      controller.setCloseFriend(false);
                    }
                    break;

                  case SettingAction.mute:
                    final result = await muteController.toggleMute(
                      targetUserId: widget.targetUserId,
                      currentState:
                          controller.userProfile.value?.isMuted ?? false,
                    );
                    if (result == MuteAction.muted) {
                      controller.setMute(true);
                    } else if (result == MuteAction.unmuted) {
                      controller.setMute(false);
                    }
                    break;

                  case SettingAction.mutual:
                    Get.to(
                      () => MutualFollowersPage(
                        targetUserId: widget.targetUserId,
                      ),
                    );

                    break;

                  case SettingAction.connection:
                    Get.to(
                      () => ConnectionAnalysisPage(
                        targetUserId: widget.targetUserId,
                      ),
                    );

                    break;

                  case SettingAction.block:
                    await blockController.toggleBlock(
                      targetUserId: widget.targetUserId,
                      currentlyBlocked: blockController.isBlocked(
                        widget.targetUserId,
                      ),
                    );
                    // blockedUserIds is an RxSet, so the Obx() around this
                    // whole action button already rebuilds on its own —
                    // no extra controller.setX(...) call needed here.
                    break;

                  case SettingAction.report:
                    Get.to(() => ReportUserPage(userId: widget.targetUserId));
                    break;
                }
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProfile,
        child: Obx(() {
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

                      isFlagged:
                          controller.userProfile.value?.isFlagged ?? false,

                      isCloseFriendOf:
                          controller.userProfile.value?.isCloseFriendOf ??
                          false,

                      isMutedBy:
                          controller.userProfile.value?.isMutedBy ?? false,

                      isFlaggedBy:
                          controller.userProfile.value?.isFlaggedBy ?? false,

                      isBlocked: blockController.isBlocked(widget.targetUserId),

                      isBlockedBy:
                          controller.userProfile.value?.isBlockedBy ?? false,

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
                      onFollowersTap: () {
                        Get.to(
                          () => FollowersPage(
                            targetUserId: widget.targetUserId,
                            type: "followers",
                          ),
                        );
                      },

                      onFollowingTap: () {
                        Get.to(
                          () => FollowersPage(
                            targetUserId: widget.targetUserId,
                            type: "following",
                          ),
                        );
                      },

                      onMessage: () {},

                      onShare: () {},
                      onMenuSelected: (action) async {
                        switch (action) {
                          case ProfileMenuAction.toggleCloseFriend:
                            final action = await closeFriendController
                                .toggleCloseFriend(
                                  targetUserId: widget.targetUserId,
                                  currentState:
                                      controller
                                          .userProfile
                                          .value
                                          ?.isCloseFriend ??
                                      false,
                                );

                            if (action == CloseFriendAction.added) {
                              controller.setCloseFriend(true);
                            }

                            if (action == CloseFriendAction.removed) {
                              controller.setCloseFriend(false);
                            }

                            break;

                          case ProfileMenuAction.toggleMute:
                            final action = await muteController.toggleMute(
                              targetUserId: widget.targetUserId,
                              currentState:
                                  controller.userProfile.value?.isMuted ??
                                  false,
                            );

                            if (action == MuteAction.muted) {
                              controller.setMute(true);
                            }

                            if (action == MuteAction.unmuted) {
                              controller.setMute(false);
                            }

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
                OtherUserPostsTab(targetUserId: widget.targetUserId),
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
                TargetUserSkillsView(targetUserId: widget.targetUserId),
                const Center(child: Text('Highlights go here')),
              ],
            ),
          );
        }),
      ),
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
