class MutedUserModel {
  final int id;
  final String fullName;
  final String email;
  final String? username;
  final String? avatarUrl;
  final String? action;
  final String? actionAt;

  MutedUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.username,
    this.avatarUrl,
    this.action,
    this.actionAt,
  });

  factory MutedUserModel.fromJson(Map<String, dynamic> json) {
    final pivot = json['pivot'] as Map<String, dynamic>?;
    final profile = json['user_profile'] as Map<String, dynamic>?;

    return MutedUserModel(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      username: profile?['username'],
      avatarUrl: profile?['avatar_full_url'],
      action: pivot?['action'],
      actionAt: pivot?['action_at'] ?? pivot?['created_at'],
    );
  }
}