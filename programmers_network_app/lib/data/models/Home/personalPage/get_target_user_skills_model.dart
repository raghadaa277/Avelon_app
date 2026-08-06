class GetUserSkillsModel {
  final bool success;
  final String message;
  final UserSkillsData data;

  GetUserSkillsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetUserSkillsModel.fromJson(Map<String, dynamic> json) {
    return GetUserSkillsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: UserSkillsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class UserSkillsData {
  final List<UserSkill> skills;

  UserSkillsData({required this.skills});

  factory UserSkillsData.fromJson(Map<String, dynamic> json) {
    return UserSkillsData(
      skills: (json['skills'] as List<dynamic>? ?? [])
          .map((e) => UserSkill.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'skills': skills.map((e) => e.toJson()).toList()};
  }
}

class UserSkill {
  final int id;
  final int userId;
  final String skill;
  final String level;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserSkill({
    required this.id,
    required this.userId,
    required this.skill,
    required this.level,
    this.createdAt,
    this.updatedAt,
  });

  factory UserSkill.fromJson(Map<String, dynamic> json) {
    return UserSkill(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      skill: json['skill'] ?? '',
      level: json['level'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'skill': skill,
      'level': level,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
