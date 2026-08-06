class UserSkillModel {
  final int id;
  final int userId;
  final String skillName;
  final String level;

  UserSkillModel({
    required this.id,
    required this.userId,
    required this.skillName,
    required this.level,
  });

  factory UserSkillModel.fromJson(Map<String, dynamic> json) {
    return UserSkillModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      skillName: json['skill'] ?? '',
      level: json['level'] ?? 'beginner',
    );
  }
}