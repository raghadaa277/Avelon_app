class ApiConstants {
  static const String baseurl = "https://e7d2-93-88-156-51.ngrok-free.app";
  static const String login = "/api/mobile/login";
  static const String register = "/api/register";
  static const String resendtoken = "/api/resend/verification/link";
  static const String forgetPassword = "/api/forget/password";
  static const String onboarding = "/api/get/onboarding/data";
  static const String complete = "/api/complete/onboarding";
  static const String refreshToken = "/api/refresh/access/token";
  static const String logout = "/api/mobile/logout";
  static const String startUserSession = "/api/start/user/session";
  static const String endUserSession = "/api/end/user/session";
  static const String getuserdaily = "/api/get/user/daily/app/usages";
  static const String getUserStatusesHistory =
      "/api/get/user/status/history/and/summary";
  static const String createPost = "/api/create/post";
  static const String getMyPosts = "/api/get/my/posts";

  //Zenab
  static const String userProfile = "/api/get/user/profile";
  static const String updateProfile = "/api/update/user/profile";
  static const String getPrivacySettings = "/api/get/user/pivacy/setting";
  static const String updatePrivacySettings = "/api/assign/user/privacy/setting";
  static const String updateAvatar = "/api/update/avatar";
  static const String removeAvatar = "/api/remove/avatar";
  static const String getUserSkills = "/api/get/user/skills";      
  static const String addUserSkill = "/api/create/user/skill";
  static const String deleteUserSkill = "/api/delete/user/skill/";

  static const String getCloseFriends = "/api/get/my/close/friends"; // جلب قائمة الأصدقاء المقربين
  static const String toggleCloseFriend = "/api/toggle/close/friend/"; // إضافة أو حذف صديق مقرب (نمرر الـ ID في النهاية)
  static const String getCloseFriendsHistory = "/api/get/close/friends/history";
  static const String toggleFollow = "/api/toggle/following/";
  static const String getFollowers = "/api/get/";
  static const String getFollowHistory = "/api/get/follow/history/";
  static const String toggleMuteUser = "/api/toggle/mute/";
  static const String getMutedUsers = "/api/get/my/muted/users";
  static const String getMutedUserHistoryMy = "/api/get/muted/user/history/my";
  static const String getMutedUserHistoryBy = "/api/get/muted/user/history/by";
}
