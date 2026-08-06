import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/profile/muted_users_cubit.dart';
import '../../../cubit/profile/muted_users_state.dart';

import '../../../data/services/profile/MutedUsersService.dart';

class MutedUsersScreen extends StatefulWidget {
  const MutedUsersScreen({super.key});

  @override
  State<MutedUsersScreen> createState() => _MutedUsersScreenState();
}

class _MutedUsersScreenState extends State<MutedUsersScreen> {
  bool isSentType = true;
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
        final type = isSentType ? 'sent' : 'received';
        context.read<MutedUsersCubit>().fetchMutedHistory(type: type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF4CAE47);
    const lightBg = Color(0xFFF8F9FA);

    return BlocProvider<MutedUsersCubit>(
      create: (context) => MutedUsersCubit(MutedUsersService())
        ..fetchMutedUsers()
        ..fetchMutedHistory(type: 'sent'),
      child: Builder(
        builder: (context) {
          _setupScrollListener(context);

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: lightBg,
              appBar: AppBar(
                backgroundColor: Colors.white,
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
                      final type = isSentType ? 'sent' : 'received';
                      context.read<MutedUsersCubit>().fetchMutedHistory(
                        type: type,
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
                  _buildMutedTab(context, primaryGreen),
                  _buildHistoryTab(context, primaryGreen),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMutedTab(BuildContext context, Color primaryGreen) {
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
        if (state is MutedUsersLoading &&
            context.read<MutedUsersCubit>().currentMutedUsers.isEmpty) {
          return Center(child: CircularProgressIndicator(color: primaryGreen));
        }

        final mutedUsers = context.read<MutedUsersCubit>().currentMutedUsers;

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
                  OutlinedButton.icon(
                    onPressed: () {
                      context.read<MutedUsersCubit>().toggleMuteUser(user.id);
                    },
                    icon: Icon(
                      Icons.volume_up_outlined,
                      size: 15,
                      color: primaryGreen,
                    ),
                    label: Text(
                      'Unmute',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE8F5E9)),
                      backgroundColor: const Color(0xFFF1F8E9),
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
                      setState(() => isSentType = true);
                      context.read<MutedUsersCubit>().fetchMutedHistory(
                        type: 'sent',
                      );
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
                      setState(() => isSentType = false);
                      context.read<MutedUsersCubit>().fetchMutedHistory(
                        type: 'received',
                      );
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
              if (state is MutedUsersLoading &&
                  context.read<MutedUsersCubit>().historyList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(color: primaryGreen),
                );
              }

              final historyList = context.read<MutedUsersCubit>().historyList;

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
                itemCount: historyList.length,
                itemBuilder: (context, index) {
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
      return "${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}";
    } catch (_) {
      return rawDate;
    }
  }
}
