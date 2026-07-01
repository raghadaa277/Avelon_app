import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/PrivacySettings/privacy_settings_cubit.dart';
import '../../../cubit/PrivacySettings/privacy_settings_state.dart';
import '../../../data/models/Profile/PrivacySettingsModel.dart';
import '../../widget/profile/SettingsSection_widget.dart';
import '../../widget/profile/SwitchTile_widget.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key, this.initialSettings});

  final PrivacySettingsModel? initialSettings;

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {

  bool hideFollowersCount = false;
  bool hideFollowingsCount = false;
  bool hideFollowersList = false;
  bool hideFollowingsList = false;

  bool showLastSeen = true;
  bool showOnlineStatus = true;

  bool allowProfileInSearch = true;
  bool allowPostsInSearch = true;
  bool allowNotifications = true;


  String messageRestriction = 'Everyone';

  static const _accentColor = Color(0xffB8FF1A);
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    context.read<PrivacySettingsCubit>().fetchSettings();
  }

  void _initializeFields(PrivacySettingsModel settings) {
    if (_isInitialized) return;
    setState(() {
      hideFollowersCount = settings.hideFollowersCount;
      hideFollowingsCount = settings.hideFollowingsCount;
      hideFollowersList = settings.hideFollowersList;
      hideFollowingsList = settings.hideFollowingsList;

      showLastSeen = settings.showLastSeen;
      showOnlineStatus = settings.showOnlineStatus;

      allowProfileInSearch = settings.allowProfileInSearch;
      allowPostsInSearch = settings.allowPostsInSearch;
      allowNotifications = settings.allowNotifications;

      final msgFrom = settings.allowMessagesFrom;
      messageRestriction = msgFrom.isNotEmpty
          ? msgFrom.substring(0, 1).toUpperCase() + msgFrom.substring(1)
          : 'Everyone';
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
              onPressed: () => Navigator.maybePop(context),
            ),
          ),
        ),
        title: const Column(
          children: [
            Text(
              'Privacy Settings',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 2),
            Text(
              'Manage your privacy and control your experience',
              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PrivacySettingsCubit, PrivacySettingsState>(
        listener: (context, state) {
          if (state is PrivacySettingsLoaded) {
            _initializeFields(state.settings);
          }
        },
        builder: (context, state) {
          if (state is PrivacySettingsLoading && !_isInitialized) {
            return const Center(child: CircularProgressIndicator(color: _accentColor));
          } else if (state is PrivacySettingsError && !_isInitialized) {
            return Center(child: Text(state.errorMessage, style: const TextStyle(color: Colors.red)));
          }


          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [

              SettingsSection(
                icon: Icons.group_outlined,
                title: 'Followers & Following',
                description: 'Control who can see your followers and following information',
                children: [
                  SwitchTile(
                    icon: Icons.person_outline,
                    title: 'Hide followers count',
                    subtitle: "Others won't see how many followers you have",
                    value: hideFollowersCount,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => hideFollowersCount = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('hide_followers_count', val ? 1 : 0);
                    },
                  ),
                  SwitchTile(
                    icon: Icons.person_outline,
                    title: 'Hide followings count',
                    subtitle: "Others won't see how many accounts you follow",
                    value: hideFollowingsCount,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => hideFollowingsCount = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('hide_followings_count', val ? 1 : 0);
                    },
                  ),
                  SwitchTile(
                    icon: Icons.visibility_off_outlined,
                    title: 'Hide followers list',
                    subtitle: "Others won't see your followers list",
                    value: hideFollowersList,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => hideFollowersList = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('hide_followers_list', val ? 1 : 0);
                    },
                  ),
                  SwitchTile(
                    icon: Icons.visibility_off_outlined,
                    title: 'Hide followings list',
                    subtitle: "Others won't see the accounts you follow",
                    value: hideFollowingsList,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => hideFollowingsList = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('hide_followings_list', val ? 1 : 0);
                    },
                  ),
                ],
              ),

              SettingsSection(
                icon: Icons.timeline_outlined,
                title: 'Activity Status',
                description: 'Manage your online presence and activity visibility',
                children: [
                  SwitchTile(
                    icon: Icons.access_time_rounded,
                    title: 'Show last seen',
                    subtitle: 'Others can see when you were last active',
                    value: showLastSeen,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => showLastSeen = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('show_last_seen', val ? 1 : 0);
                    },
                  ),
                  SwitchTile(
                    icon: Icons.access_time_rounded,
                    title: 'Show online status',
                    subtitle: 'Others can see when you are online',
                    value: showOnlineStatus,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => showOnlineStatus = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('show_online_status', val ? 1 : 0);
                    },
                  ),
                ],
              ),


              SettingsSection(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Messages',
                description: 'Control who can send you messages',
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1FDE1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.badge_outlined, size: 18, color: Colors.black87),
                    ),
                    title: const Text(
                      'Allow messages from',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Choose who can send you messages',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: messageRestriction,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() => messageRestriction = newValue);
                              context.read<PrivacySettingsCubit>().updateSingleSetting('allow_messages_from', newValue.toLowerCase());
                            }
                          },
                          items: <String>['Everyone', 'Followers', 'Nobody']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


              SettingsSection(
                icon: Icons.search_rounded,
                title: 'Search & Discovery',
                description: 'Control your visibility in search results',
                children: [
                  SwitchTile(
                    icon: Icons.person_search_outlined,
                    title: 'Allow profile in search',
                    subtitle: 'Allow your profile to appear in search results',
                    value: allowProfileInSearch,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => allowProfileInSearch = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('allow_profile_in_search', val ? 1 : 0);
                    },
                  ),
                  SwitchTile(
                    icon: Icons.article_outlined,
                    title: 'Allow posts in search',
                    subtitle: 'Allow your posts to appear in search results',
                    value: allowPostsInSearch,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => allowPostsInSearch = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('allow_posts_in_search', val ? 1 : 0);
                    },
                  ),
                ],
              ),


              SettingsSection(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                description: 'Control your notification preferences',
                children: [
                  SwitchTile(
                    icon: Icons.watch_later_outlined,
                    title: 'Allow notifications',
                    subtitle: 'Receive push notifications from the app',
                    value: allowNotifications,
                    activeColor: _accentColor,
                    onChanged: (val) {
                      setState(() => allowNotifications = val);
                      context.read<PrivacySettingsCubit>().updateSingleSetting('allow_notifications', val ? 1 : 0);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}