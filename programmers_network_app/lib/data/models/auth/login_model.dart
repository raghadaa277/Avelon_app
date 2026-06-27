class UserModel {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }
}

class DataLoginModel {
  final String accessToken;
  final String refreshToken;
  final String profileCompletion;
  final UserModel users;

  DataLoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.profileCompletion,
    required this.users,
  });
  factory DataLoginModel.fromJson(Map<String, dynamic> json) {
    return DataLoginModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      profileCompletion: json['profile_completion'] ?? '0%',
      users: UserModel.fromJson(json['user'] ?? {}),
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
      success: json['success'] ?? '',
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
  final String platform;
  final String browser;
  final String fcmToken;

  LoginRequest({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.device,
    required this.platform,
    required this.browser,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "device_id": deviceId,
      "device": device,
      "platform": platform,
      "browser": browser,
      "fcm_token": fcmToken,
    };
  }
}
