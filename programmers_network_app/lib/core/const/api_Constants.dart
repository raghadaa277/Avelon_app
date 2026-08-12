class ApiConstants {
  static const String baseurl = "https://1cfb-89-33-8-51.ngrok-free.app";
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
  static const String tagePost = "/api/get/tags";
  static const String getMyPosts = "/api/get/my/posts";
  static const String archivePost = "/api/archive/post";
  static const String getArchivedPosts = "/api/get/archived/posts";
  static const String restorePost = "/api/restore/post";
  static const String forceDeletePost = "/api/force/delete/post";
  static const String pinnedPost = "/api/toggle/pinned/post";
  static const String deletePostMedia = "/api/delete/post/media";
  static const String search = "/api/search";
  static const String searchPost = "/api/search";
  static const String postReactions = "/api/toggle/post/reaction";
  static const String getPostReactions = "/api/get/post/reactions";
  static const String savePost = "/api/toggle/saved/post";
  static const String saveRecordPost = "/api/record/post/view";
  static const String getPostViews = "/api/get/post/views";
  static const String getPostComments = "/api/get/post/comments";
  static const String repliesComment = "/api/get/comment/replies";
  static const String createComment = "/api/create/comment";
  static const String deleteComment = "/api/delete/comment";
  static const String commentReactions = "/api/toggle/comment/reaction";
  static const String getCommentReactions = "/api/get/comment/reactions";
  static const String editComment = "/api/update/comment";
  static const String getTargetUserCount = "/api/get/target/user/counts";
  static const String getOtherUserProfile = "/api/get/target/user/profile";
  static const String toggleFollowing = "/api/toggle/following";
  static const String getFollows = "/api/get";
  static const String toggleCloseFriend = "/api/toggle/close/friend";
  static const String getMyCloseFriends = "/api/get/my/close/friends";
  static const String toggleMute = "/api/toggle/mute";
  static const String toggleBlock = "/api/toggle/block";
  static const String userFlag = "/api/flag/user";
  static const String recordProfileView = "/api/record/profile/view";
  static const String mutualFollowers = "/api/mutual/followers";
  static const String connentionAnalysis = "/api/connection/analysis";
  static const String getTargetUserPost = "/api/get/target/user/posts";
  static const String getTargetUserSkills = "/api/get/target/user/skills";
  static const String blockUser = "/api/toggle/block";
  static const String getSavePost = "/api/get/saved/posts";
  static const String getSearchHistory = "/api/get/search/histories";
  static const String clearOneSearchHistory = "/api/delete/search/history";
  static const String clearAllSearchHistory = "/api/delete/all/search/history";

  //Zenab
  static const String userProfile = "/api/get/user/profile";
  static const String updateProfile = "/api/update/user/profile";
  static const String getPrivacySettings = "/api/get/user/pivacy/setting";
  static const String updatePrivacySettings =
      "/api/assign/user/privacy/setting";
  static const String updateAvatar = "/api/update/avatar";
  static const String removeAvatar = "/api/remove/avatar";
  static const String getUserSkills = "/api/get/user/skills";
  static const String addUserSkill = "/api/create/user/skill";
  static const String deleteUserSkill = "/api/delete/user/skill/";
  static const String getCloseFriends = "/api/get/my/close/friends";
  static const String getCloseFriendsHistory = "/api/get/close/friends/history";

  static const String getFollowers = "/api/get/";
  static const String getFollowHistory = "/api/get/follow/history/";

  static const String getMutedUsers = "/api/get/my/muted/users";
  static const String getMutedUserHistoryMy = "/api/get/muted/user/history/my";
  static const String getMutedUserHistoryBy = "/api/get/muted/user/history/by";
}
