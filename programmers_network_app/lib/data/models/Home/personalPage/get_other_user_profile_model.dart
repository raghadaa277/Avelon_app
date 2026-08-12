class DataOtherUserProfile {
  final int id;
  final int userId;
  final String? username;
  final String? bio;
  final String? educationStatus;
  final String? university;
  final String? major;
  final String? studyYear;
  final String? country;
  final String? city;
  final String? specialization;
  final String? jobTitle;
  final String? company;
  final String? githubUrl;
  final String? linkedinUrl;
  final String? birthDate;
  final int? experienceYears;
  final String? createdAt;
  final String? updatedAt;
  final bool isFlagged;
  final bool isMuted;
  final bool isCloseFriend;
  final bool isBlockedBy;
  final String followStatus;
  final bool isFlaggedBy;
  final bool isMutedBy;
  final bool isCloseFriendOf;
  final String? fullName;
  final String? avatarFullUrl;

  DataOtherUserProfile({
    required this.id,
    required this.userId,
    this.username,
    this.bio,
    this.educationStatus,
    this.university,
    this.major,
    this.studyYear,
    this.country,
    this.city,
    this.specialization,
    this.jobTitle,
    this.company,
    this.githubUrl,
    this.linkedinUrl,
    this.birthDate,
    this.experienceYears,
    this.createdAt,
    this.updatedAt,
    required this.isFlagged,
    required this.isMuted,
    required this.isCloseFriend,
    required this.isBlockedBy,
    required this.followStatus,
    required this.isFlaggedBy,
    required this.isMutedBy,
    required this.isCloseFriendOf,
    this.fullName,
    this.avatarFullUrl,
  });
  DataOtherUserProfile copyWith({
    bool? isCloseFriend,
    bool? isMuted,
    bool? isFlagged,
    String? followStatus,
  }) {
    return DataOtherUserProfile(
      id: id,
      userId: userId,
      username: username,
      bio: bio,
      educationStatus: educationStatus,
      university: university,
      major: major,
      studyYear: studyYear,
      country: country,
      city: city,
      specialization: specialization,
      jobTitle: jobTitle,
      company: company,
      githubUrl: githubUrl,
      linkedinUrl: linkedinUrl,
      birthDate: birthDate,
      experienceYears: experienceYears,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fullName: fullName,
      avatarFullUrl: avatarFullUrl,
      followStatus: followStatus ?? this.followStatus,
      isCloseFriend: isCloseFriend ?? this.isCloseFriend,
      isMuted: isMuted ?? this.isMuted,
      isFlagged: isFlagged ?? this.isFlagged,
      isCloseFriendOf: isCloseFriendOf,
      isMutedBy: isMutedBy,
      isBlockedBy: isBlockedBy,
      isFlaggedBy: isFlaggedBy,
    );
  }

  factory DataOtherUserProfile.fromJson(Map<String, dynamic> json) {
    return DataOtherUserProfile(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      username: json['username'],
      bio: json['bio'],
      educationStatus: json['education_status'],
      university: json['university'],
      major: json['major'],
      studyYear: json['study_year'],
      country: json['country'],
      city: json['city'],
      specialization: json['specialization'],
      jobTitle: json['job_title'],
      company: json['company'],
      githubUrl: json['github_url'],
      linkedinUrl: json['linkedin_url'],
      birthDate: json['birth_date'],
      experienceYears: json['experience_years'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isFlagged: (json['is_flagged'] ?? 0) == 1,
      isMuted: (json['is_muted'] ?? 0) == 1,
      isCloseFriend: (json['is_close_friend'] ?? 0) == 1,
      followStatus: json['follow_status'] ?? 'none',
      isFlaggedBy: (json['is_flagged_by'] ?? 0) == 1,
      isMutedBy: (json['is_muted_by'] ?? 0) == 1,
      isBlockedBy: json['is_blocked_by'] ?? false,
      isCloseFriendOf: (json['is_close_friend_of'] ?? 0) == 1,
      fullName: json['full_name'],
      avatarFullUrl: json['avatar_full_url'],
    );
  }
}

class GetOtherUserProfileModel {
  final bool success;
  final String message;
  final DataOtherUserProfile data;

  GetOtherUserProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetOtherUserProfileModel.fromJson(Map<String, dynamic> json) {
    return GetOtherUserProfileModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataOtherUserProfile.fromJson(json['data'] ?? {}),
    );
  }
}
