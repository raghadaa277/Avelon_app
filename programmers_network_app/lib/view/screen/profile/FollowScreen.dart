import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import '../../../cubit/profile/follow_cubit.dart';
import '../../../cubit/profile/follow_state.dart';
import '../../../data/models/Profile/UserFollowModel.dart';
import '../../../data/services/profile/FollowService.dart';

class FollowScreen extends StatefulWidget {
  final int userId;

  const FollowScreen({super.key, required this.userId});

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  bool isFollowingType = true;
  final ScrollController _historyScrollController = ScrollController();

  @override
  void dispose() {
    _historyScrollController.dispose();
    super.dispose();
  }

  void _setupScrollListener(BuildContext context) {
    _historyScrollController.addListener(() {
      if (_historyScrollController.position.pixels >=
          _historyScrollController.position.maxScrollExtent - 200) {
        final type = isFollowingType ? 'followings' : 'followers';
        context.read<FollowCubit>().fetchFollowHistory(
          type: type,
          isLoadMore: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF4CAE47);

    // ⭕ تغليف الشاشة بالكامل بالـ BlocProvider يضمن توفر الـ Cubit في أي Context داخلي
    return BlocProvider<FollowCubit>(
      create: (context) =>
          FollowCubit(FollowService())..fetchFollowers(widget.userId),
      child: Builder(
        builder: (context) {
          _setupScrollListener(context);

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: ColorConst.colorBackGroung,
              appBar: AppBar(
                backgroundColor: ColorConst.colorBackGroung,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_add_alt_1_outlined, color: primaryGreen),
                    SizedBox(width: 8),
                    Text(
                      'Followers & History',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: primaryGreen,
                  indicatorWeight: 3,
                  labelColor: primaryGreen,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  onTap: (index) {
                    if (index == 1) {
                      final type = isFollowingType ? 'followings' : 'followers';
                      context.read<FollowCubit>().fetchFollowHistory(
                        type: type,
                      );
                    }
                  },
                  tabs: const [
                    Tab(text: "Followers List"),
                    Tab(text: "Follow History"),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildFollowersTab(context, primaryGreen),
                  _buildHistoryTab(context, primaryGreen),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFollowersTab(BuildContext context, Color primaryGreen) {
    return BlocConsumer<FollowCubit, FollowState>(
      listener: (context, state) {
        if (state is FollowError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FollowLoading) {
          return Center(child: CircularProgressIndicator(color: primaryGreen));
        }

        List<UserFollowModel> followers = [];
        if (state is FollowersLoaded) {
          followers = state.followers;
        }

        if (followers.isEmpty) {
          return const Center(
            child: Text(
              "No followers found",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemCount: followers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final user = followers[index];

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFEEEEEE),
                    backgroundImage: user.avatarFullUrl != null
                        ? NetworkImage(user.avatarFullUrl!)
                        : null,
                    child: user.avatarFullUrl == null
                        ? const Icon(Icons.person, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.email,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHistoryTab(BuildContext context, Color primaryGreen) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => isFollowingType = true);
                      context.read<FollowCubit>().fetchFollowHistory(
                        type: 'followings',
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isFollowingType
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_upward_outlined,
                            size: 18,
                            color: isFollowingType ? primaryGreen : Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Followings',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isFollowingType
                                  ? primaryGreen
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => isFollowingType = false);
                      context.read<FollowCubit>().fetchFollowHistory(
                        type: 'followers',
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !isFollowingType
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward_outlined,
                            size: 18,
                            color: !isFollowingType
                                ? primaryGreen
                                : Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !isFollowingType
                                  ? primaryGreen
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<FollowCubit, FollowState>(
            builder: (context, state) {
              if (state is FollowLoading) {
                return Center(
                  child: CircularProgressIndicator(color: primaryGreen),
                );
              }

              List<UserFollowModel> historyList = [];
              if (state is FollowHistoryLoaded) {
                historyList = state.historyItems;
              }

              if (historyList.isEmpty) {
                return const Center(
                  child: Text(
                    "No follow history logs found",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                );
              }

              return ListView.builder(
                controller: _historyScrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  final item = historyList[index];
                  final bool isFollowAction =
                      item.action?.toLowerCase() == 'follow';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isFollowAction
                                ? const Color(0xFFE8F5E9)
                                : const Color(0xFFFFEBEE),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFollowAction
                                ? Icons.person_add_alt_outlined
                                : Icons.person_remove_outlined,
                            color: isFollowAction
                                ? primaryGreen
                                : Colors.redAccent,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFFEEEEEE),
                          backgroundImage: item.avatarFullUrl != null
                              ? NetworkImage(item.avatarFullUrl!)
                              : null,
                          child: item.avatarFullUrl == null
                              ? const Icon(Icons.person, color: Colors.grey)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.fullName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                isFollowAction ? 'Followed' : 'Unfollowed',
                                style: TextStyle(
                                  color: isFollowAction
                                      ? primaryGreen
                                      : Colors.redAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item.actionAt ?? '',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
