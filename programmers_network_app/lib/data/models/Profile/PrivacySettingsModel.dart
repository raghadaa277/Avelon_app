class PrivacySettingsModel {
  final bool hideFollowersCount;
  final bool hideFollowingsCount;
  final bool hideFollowersList;
  final bool hideFollowingsList;
  final bool showLastSeen;
  final bool showOnlineStatus;
  final String allowMessagesFrom;
  final bool allowProfileInSearch;
  final bool allowPostsInSearch;
  final bool allowNotifications;

  PrivacySettingsModel({
    required this.hideFollowersCount,
    required this.hideFollowingsCount,
    required this.hideFollowersList,
    required this.hideFollowingsList,
    required this.showLastSeen,
    required this.showOnlineStatus,
    required this.allowMessagesFrom,
    required this.allowProfileInSearch,
    required this.allowPostsInSearch,
    required this.allowNotifications,
  });


  factory PrivacySettingsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return PrivacySettingsModel(
      hideFollowersCount: data['hide_followers_count'] == 1,
      hideFollowingsCount: data['hide_followings_count'] == 1,
      hideFollowersList: data['hide_followers_list'] == 1,
      hideFollowingsList: data['hide_followings_list'] == 1,
      showLastSeen: data['show_last_seen'] == 1,
      showOnlineStatus: data['show_online_status'] == 1,
      allowMessagesFrom: data['allow_messages_from'] ?? 'everyone',
      allowProfileInSearch: data['allow_profile_in_search'] == 1,
      allowPostsInSearch: data['allow_posts_in_search'] == 1,
      allowNotifications: data['allow_notifications'] == 1,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'hide_followers_count': hideFollowersCount ? 1 : 0,
      'hide_followings_count': hideFollowingsCount ? 1 : 0,
      'hide_followers_list': hideFollowersList ? 1 : 0,
      'hide_followings_list': hideFollowingsList ? 1 : 0,
      'show_last_seen': showLastSeen ? 1 : 0,
      'show_online_status': showOnlineStatus ? 1 : 0,
      'allow_messages_from': allowMessagesFrom.toLowerCase(),
      'allow_profile_in_search': allowProfileInSearch ? 1 : 0,
      'allow_posts_in_search': allowPostsInSearch ? 1 : 0,
      'allow_notifications': allowNotifications ? 1 : 0,
    };
  }
}