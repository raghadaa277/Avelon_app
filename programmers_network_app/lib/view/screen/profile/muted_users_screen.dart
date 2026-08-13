import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import '../../../cubit/profile/muted_users_cubit.dart';
import '../../../cubit/profile/muted_users_state.dart';
import '../../../data/services/profile/MutedUsersService.dart';

class MutedUsersScreen extends StatelessWidget {
  const MutedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MutedUsersCubit(MutedUsersService())
        ..fetchMutedUsers()
        ..fetchMutedHistory(type: 'sent'),
      child: const _MutedUsersView(),
    );
  }
}

class _MutedUsersView extends StatefulWidget {
  const _MutedUsersView();

  @override
  State<_MutedUsersView> createState() => _MutedUsersViewState();
}

class _MutedUsersViewState extends State<_MutedUsersView> {
  bool isSentType = true;

  final ScrollController _historyScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _historyScrollController.addListener(_onHistoryScroll);
  }

  void _onHistoryScroll() {
    if (!_historyScrollController.hasClients) return;

    final position = _historyScrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<MutedUsersCubit>().loadMoreHistory();
    }
  }

  @override
  void dispose() {
    _historyScrollController.removeListener(_onHistoryScroll);
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
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.volume_off_outlined, color: primaryGreen),
              SizedBox(width: 8),
              Text(
                'Muted Accounts & History',
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
                context.read<MutedUsersCubit>().fetchMutedHistory(
                  type: isSentType ? 'sent' : 'received',
                  page: 1,
                );
              }
            },
            tabs: const [
              Tab(text: "Muted List"),
              Tab(text: "Mute History"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMutedTab(primaryGreen),
            _buildHistoryTab(primaryGreen),
          ],
        ),
      ),
    );
  }

  Widget _buildMutedTab(Color primaryGreen) {
    return BlocConsumer<MutedUsersCubit, MutedUsersState>(
      listener: (context, state) {
        if (state is MutedUsersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<MutedUsersCubit>();

        if (state is MutedUsersLoading && cubit.currentMutedUsers.isEmpty) {
          return Center(child: CircularProgressIndicator(color: primaryGreen));
        }

        final mutedUsers = cubit.currentMutedUsers;

        if (mutedUsers.isEmpty) {
          return const Center(
            child: Text(
              "No muted users found",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemCount: mutedUsers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final user = mutedUsers[index];

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
                    backgroundImage:
                        (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
                        ? NetworkImage(user.avatarUrl!)
                        : null,
                    child: (user.avatarUrl == null || user.avatarUrl!.isEmpty)
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

  Widget _buildHistoryTab(Color primaryGreen) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
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
                      if (!isSentType) {
                        setState(() {
                          isSentType = true;
                        });

                        context.read<MutedUsersCubit>().fetchMutedHistory(
                          type: 'sent',
                          page: 1,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSentType ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_upward_outlined,
                            size: 18,
                            color: isSentType ? primaryGreen : Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Sent',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSentType ? primaryGreen : Colors.grey,
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
                      if (isSentType) {
                        setState(() {
                          isSentType = false;
                        });

                        context.read<MutedUsersCubit>().fetchMutedHistory(
                          type: 'received',
                          page: 1,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !isSentType ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward_outlined,
                            size: 18,
                            color: !isSentType ? primaryGreen : Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Received',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !isSentType ? primaryGreen : Colors.grey,
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
          child: BlocBuilder<MutedUsersCubit, MutedUsersState>(
            builder: (context, state) {
              final cubit = context.read<MutedUsersCubit>();

              if (state is MutedHistoryLoading && cubit.historyList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(color: primaryGreen),
                );
              }

              final historyList = cubit.historyList;

              if (historyList.isEmpty) {
                return const Center(
                  child: Text(
                    "No mute history logs found",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                );
              }

              return ListView.builder(
                controller: _historyScrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: historyList.length + (cubit.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  // Loading indicator for next page
                  if (index == historyList.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  final item = historyList[index];

                  final bool isMuteAction = item.action?.toLowerCase() == 'add';

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
                            color: isMuteAction
                                ? const Color(0xFFFFEBEE)
                                : const Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isMuteAction
                                ? Icons.volume_off_outlined
                                : Icons.volume_up_outlined,
                            color: isMuteAction
                                ? Colors.redAccent
                                : primaryGreen,
                            size: 18,
                          ),
                        ),

                        const SizedBox(width: 12),

                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFFEEEEEE),
                          backgroundImage:
                              (item.avatarUrl != null &&
                                  item.avatarUrl!.isNotEmpty)
                              ? NetworkImage(item.avatarUrl!)
                              : null,
                          child:
                              (item.avatarUrl == null ||
                                  item.avatarUrl!.isEmpty)
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
                                isMuteAction ? 'Muted' : 'Unmuted',
                                style: TextStyle(
                                  color: isMuteAction
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
                              _formatDate(item.actionAt ?? ''),
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

  String _formatDate(String rawDate) {
    try {
      final parsed = DateTime.parse(rawDate);

      return "${parsed.year}-"
          "${parsed.month.toString().padLeft(2, '0')}-"
          "${parsed.day.toString().padLeft(2, '0')}";
    } catch (_) {
      return rawDate;
    }
  }
}
