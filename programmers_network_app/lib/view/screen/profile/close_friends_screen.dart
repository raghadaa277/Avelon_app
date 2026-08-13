import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import '../../../cubit/profile/close_friends_cubit.dart';
import '../../../cubit/profile/close_friends_state.dart';
import '../../../data/models/Profile/close_friend_model.dart';

class CloseFriendsScreen extends StatefulWidget {
  const CloseFriendsScreen({super.key});

  @override
  State<CloseFriendsScreen> createState() => _CloseFriendsScreenState();
}

class _CloseFriendsScreenState extends State<CloseFriendsScreen> {
  bool isMyActions = true;
  final ScrollController _historyScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<CloseFriendsCubit>().fetchCloseFriends();

    _historyScrollController.addListener(() {
      if (_historyScrollController.position.pixels >=
          _historyScrollController.position.maxScrollExtent - 200) {
        // عند السحب للأسفل يتم إرسال طلب الصفحة التالية كـ Query Param (?page=2)
        // context.read<CloseFriendsCubit>().loadMoreHistory();
      }
    });
  }

  @override
  void dispose() {
    _historyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF4CAE47);

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
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.people_alt_outlined, color: primaryGreen),
              SizedBox(width: 8),
              Text(
                'Get My Close',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          bottom: const TabBar(
            indicatorColor: primaryGreen,
            indicatorWeight: 3,
            labelColor: primaryGreen,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: [
              Tab(text: "Close Friends"),
              Tab(text: "History "),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCloseFriendsTab(primaryGreen),
            _buildHistoryTab(primaryGreen),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseFriendsTab(Color primaryGreen) {
    return BlocConsumer<CloseFriendsCubit, CloseFriendsState>(
      listener: (context, state) {
        if (state is CloseFriendsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CloseFriendsLoading) {
          return Center(child: CircularProgressIndicator(color: primaryGreen));
        }

        List<CloseFriendModel> friends = [];
        if (state is CloseFriendsLoaded) {
          friends = state.closeFriends;
        }

        if (friends.isEmpty) {
          return const Center(
            child: Text(
              "No close friends added yet",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemCount: friends.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final friend = friends[index];

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0xFFEEEEEE),
                        child: Icon(Icons.person, color: Colors.grey),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.star,
                            color: primaryGreen,
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          friend.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          friend.email,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.read<CloseFriendsCubit>().toggleCloseFriend(
                        friend.id,
                      );
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 15,
                      color: Colors.redAccent,
                    ),
                    label: const Text(
                      'Unclose',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFFEBEE)),
                      backgroundColor: const Color(0xFFFFF5F5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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

  Widget _buildHistoryTab(Color primaryGreen) {
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
                    onTap: () => setState(() => isMyActions = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isMyActions ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 18,
                            color: isMyActions ? primaryGreen : Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'sent',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isMyActions ? primaryGreen : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isMyActions = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !isMyActions ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 18,
                            color: !isMyActions ? primaryGreen : Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'received',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !isMyActions ? primaryGreen : Colors.grey,
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
          child: BlocBuilder<CloseFriendsCubit, CloseFriendsState>(
            builder: (context, state) {
              if (state is CloseFriendsLoading) {
                return Center(
                  child: CircularProgressIndicator(color: primaryGreen),
                );
              }

              List historyList = [];
              if (state is CloseFriendsHistoryLoaded) {
                historyList = state.historyItems;
              }

              if (historyList.isEmpty) {
                return const Center(
                  child: Text(
                    "No history logs found",
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
                  final bool isMuted =
                      item.actionType?.toLowerCase() == 'muted';

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
                            color: isMuted
                                ? const Color(0xFFFFEBEE)
                                : const Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isMuted
                                ? Icons.volume_off_outlined
                                : Icons.volume_up_outlined,
                            color: isMuted ? Colors.redAccent : primaryGreen,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFFEEEEEE),
                          child: Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.userName ?? 'User',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                isMuted ? 'Muted' : 'Unmuted',
                                style: TextStyle(
                                  color: isMuted
                                      ? Colors.redAccent
                                      : primaryGreen,
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
                              item.createdAt ?? '',
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
