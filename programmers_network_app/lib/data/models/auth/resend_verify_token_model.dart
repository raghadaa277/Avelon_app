class DataResendVerifyToken {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  DataResendVerifyToken({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataResendVerifyToken.fromJson(Map<String, dynamic> json) {
    return DataResendVerifyToken(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }
}

class ResendVerifyTokenModel {
  final bool success;
  final String message;
  final DataResendVerifyToken data;

  ResendVerifyTokenModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResendVerifyTokenModel.fromJson(Map<String, dynamic> json) {
    return ResendVerifyTokenModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataResendVerifyToken.fromJson(json['data'] ?? {}),
    );
  }
}
