class UserProfileModel {
  final bool success;
  final String message;
  final ProfileData data;
  final String? profileCompletion;
  UserProfileModel({
    required this.success,
    required this.message,
    required this.data,
   required this.profileCompletion,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ProfileData.fromJson(json['data'] ?? {}),
     profileCompletion: json['data'] != null ? json['data']['profile_completion'] : null,
    );
  }
}

class ProfileData {
  final int id;
  final int userId;
  final String username;
  final String fullName;
  final String bio;
  final String educationStatus;
  final String university;
  final String? major;
  final String studyYear;
  final String country;
  final String city;
  final String specialization;
  final String jobTitle;
  final String? company;
  final String? githubUrl;
  final String? linkedinUrl;
  final String birthDate;
  final int experienceYears;
  final String? avatarFullUrl;

  ProfileData({
    required this.id,
    required this.userId,
    required this.username,
    required this.fullName,
    required this.bio,
    required this.educationStatus,
    required this.university,
    this.major,
    required this.studyYear,
    required this.country,
    required this.city,
    required this.specialization,
    required this.jobTitle,
    this.company,
    this.githubUrl,
    this.linkedinUrl,
    required this.birthDate,
    required this.experienceYears,
    this.avatarFullUrl,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? 'user',
      fullName: json['full_name'] ?? 'No Name',
      bio: json['bio'] ?? '...',
      educationStatus: json['education_status'] ?? '',
      university: json['university'] ?? '',
      major: json['major'],
      studyYear: json['study_year'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      specialization: json['specialization'] ?? '',
      jobTitle: json['job_title'] ?? '',
      company: json['company'],
      githubUrl: json['github_url'],
      linkedinUrl: json['linkedin_url'],
      birthDate: json['birth_date'] ?? '',
      experienceYears: json['experience_years'] ?? 0,
      avatarFullUrl: json['avatar_full_url'],
    );
  }


}