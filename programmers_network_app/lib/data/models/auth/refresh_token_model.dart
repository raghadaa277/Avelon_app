class RefreshTokenData {
  final String accessToken;
  final String refreshToken;

  RefreshTokenData({required this.accessToken, required this.refreshToken});

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) {
    return RefreshTokenData(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
}

class RefreshTokenModel {
  final bool success;
  final String message;
  final RefreshTokenData data;

  RefreshTokenModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: RefreshTokenData.fromJson(json['data'] ?? {}),
    );
  }
}
