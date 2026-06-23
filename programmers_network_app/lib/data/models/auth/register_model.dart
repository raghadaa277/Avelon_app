class DataRegisterModel {
  final String fullName;
  final String email;
  final int roleId;
  final DateTime updateAt;
  final DateTime createdAt;
  final int id;

  DataRegisterModel({
    required this.fullName,
    required this.email,
    required this.roleId,
    required this.updateAt,
    required this.createdAt,
    required this.id,
  });

  factory DataRegisterModel.fromJson(Map<String, dynamic> json) {
    return DataRegisterModel(
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      roleId: json['role_id'] ?? 0,
      updateAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      id: json['id'] ?? 0,
    );
  }
}

class RegisterModel {
  final bool success;
  final String message;
  final DataRegisterModel data;

  RegisterModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataRegisterModel.fromJson(json['data'] ?? {}),
    );
  }
}
