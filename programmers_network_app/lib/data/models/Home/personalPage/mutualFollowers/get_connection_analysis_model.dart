class ConnectionModel {
  final int percentage;
  final String status;

  ConnectionModel({required this.percentage, required this.status});

  factory ConnectionModel.fromJson(Map<String, dynamic> json) {
    return ConnectionModel(
      percentage: json['percentage'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}

class ProfileViewsConnectionModel {
  final int iVisitedHim;
  final int heVisitedMe;
  final int iVisitedHimPercentage;
  final int heVisitedMePercentage;

  ProfileViewsConnectionModel({
    required this.iVisitedHim,
    required this.heVisitedMe,
    required this.iVisitedHimPercentage,
    required this.heVisitedMePercentage,
  });

  factory ProfileViewsConnectionModel.fromJson(Map<String, dynamic> json) {
    return ProfileViewsConnectionModel(
      iVisitedHim: json['i_visited_him'] ?? 0,
      heVisitedMe: json['he_visited_me'] ?? 0,
      iVisitedHimPercentage: json['i_visited_him_percentage'] ?? 0,
      heVisitedMePercentage: json['he_visited_me_percentage'] ?? 0,
    );
  }
}

class InterestsModel {
  final int commonCount;
  final int percentage;

  InterestsModel({required this.commonCount, required this.percentage});

  factory InterestsModel.fromJson(Map<String, dynamic> json) {
    return InterestsModel(
      commonCount: json['common_count'] ?? 0,
      percentage: json['percentage'] ?? 0,
    );
  }
}

class MutualFollowersModel {
  final int count;
  final int percentage;

  MutualFollowersModel({required this.count, required this.percentage});

  factory MutualFollowersModel.fromJson(Map<String, dynamic> json) {
    return MutualFollowersModel(
      count: json['count'] ?? 0,
      percentage: json['percentage'] ?? 0,
    );
  }
}

class ConnectionAnalysisData {
  final MutualFollowersModel mutualFollowers;
  final InterestsModel interests;
  final ProfileViewsConnectionModel profileViews;
  final ConnectionModel connection;

  ConnectionAnalysisData({
    required this.mutualFollowers,
    required this.interests,
    required this.profileViews,
    required this.connection,
  });

  factory ConnectionAnalysisData.fromJson(Map<String, dynamic> json) {
    return ConnectionAnalysisData(
      mutualFollowers: MutualFollowersModel.fromJson(
        json['mutual_followers'] ?? {},
      ),
      interests: InterestsModel.fromJson(json['interests'] ?? {}),
      profileViews: ProfileViewsConnectionModel.fromJson(
        json['profile_views'] ?? {},
      ),
      connection: ConnectionModel.fromJson(json['connection'] ?? {}),
    );
  }
}

class GetConnectionAnalysisModel {
  final bool success;
  final String message;
  final ConnectionAnalysisData data;

  GetConnectionAnalysisModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetConnectionAnalysisModel.fromJson(Map<String, dynamic> json) {
    return GetConnectionAnalysisModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ConnectionAnalysisData.fromJson(json['data'] ?? {}),
    );
  }
}
