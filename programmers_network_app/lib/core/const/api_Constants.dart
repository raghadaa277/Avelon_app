class ApiConstants {
  static const String baseurl = "https://f940-185-132-176-177.ngrok-free.app";
  static const String login = "/api/mobile/login";
  static const String register = "/api/register";
  static const String resendtoken = "/api/resend/verification/link";
  static const String forgetPassword = "/api/forget/password";
  static const String onboarding = "/api/get/onboarding/data";
  static const String complete = "/api/complete/onboarding";
  static const String refreshToken = "/api/refresh/access/token";
  static const String userProfile = "$baseurl/api/get/user/profile";
  static const String updateProfile = "$baseurl/api/update/user/profile";
  static const String logout = "/api/mobile/logout";
  static const String startUserSession = "/api/start/user/session";
  static const String endUserSession = "/api/end/user/session";
}
