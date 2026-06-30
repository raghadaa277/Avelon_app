class RoleModel {
  final int id;
  final String name;

  RoleModel({required this.id, required this.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}

class UserModel {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? onboardingCompletedAt;
  final RoleModel role;

  UserModel({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.onboardingCompletedAt,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',

      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),

      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),

      onboardingCompletedAt: json['onboarding_completed_at'] != null
          ? DateTime.tryParse(json['onboarding_completed_at'].toString())
          : null,

      role: json['role'] != null
          ? RoleModel.fromJson(json['role'])
          : RoleModel(id: 0, name: ''),
    );
  }
}

class DataLoginModel {
  final String accessToken;
  final String refreshToken;
  final UserModel user;
  final String profileCompletion;
  final DateTime? onboardingCompletedAt;

  DataLoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.profileCompletion,
    required this.onboardingCompletedAt,
  });

  factory DataLoginModel.fromJson(Map<String, dynamic> json) {
    return DataLoginModel(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      profileCompletion: json['profile_completion'] ?? '0%',
      user: UserModel.fromJson(json['user'] ?? {}),
      onboardingCompletedAt: json['onboarding_completed_at'] != null
          ? DateTime.tryParse(json['onboarding_completed_at'].toString())
          : null,
    );
  }
}

class LoginModel {
  final bool success;
  final String message;
  final DataLoginModel data;

  LoginModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataLoginModel.fromJson(json['data'] ?? {}),
    );
  }
}

class LoginRequest {
  final String email;
  final String password;
  final String deviceId;
  final String device;
  final String fcmToken;

  LoginRequest({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.device,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "device_id": deviceId,
      "device": device,
      "fcm_token": fcmToken,
    };
  }
}
