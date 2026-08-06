class UserFollowModel {
  final int id;
  final int? roleId;
  final String fullName;
  final String email;
  final String? username;
  final String? avatarFullUrl;
  final String? action;   // "follow" or "unfollow"
  final String? actionAt;

  UserFollowModel({
    required this.id,
    this.roleId,
    required this.fullName,
    required this.email,
    this.username,
    this.avatarFullUrl,
    this.action,
    this.actionAt,
  });

  factory UserFollowModel.fromJson(Map<String, dynamic> json) {
    final pivot = json['pivot'] as Map<String, dynamic>?;
    final profile = json['user_profile'] as Map<String, dynamic>?;

    return UserFollowModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      username: profile?['username'],
      avatarFullUrl: profile?['avatar_full_url'],
      action: pivot?['action'],
      actionAt: pivot?['action_at'],
    );
  }
}