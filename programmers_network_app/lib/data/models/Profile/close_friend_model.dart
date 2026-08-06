class CloseFriendModel {
  final int id;
  final int? roleId;
  final String fullName;
  final String email;
  final String? onboardingCompletedAt;

  CloseFriendModel({
    required this.id,
    this.roleId,
    required this.fullName,
    required this.email,
    this.onboardingCompletedAt,
  });

  factory CloseFriendModel.fromJson(Map<String, dynamic> json) {
    return CloseFriendModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: json['onboarding_completed_at'],
    );
  }
}