

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/Profile/profile_model.dart';
import '../../core/services/profile_services.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileServices service;

  UserProfileModel? _cachedProfile;

  int _activeTabIndex = 0;
  ProfileCubit({required this.service}) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      _cachedProfile = await service.getUserProfile();
      emit(ProfileLoaded
        (profileModel: _cachedProfile!, activeTabIndex: _activeTabIndex,));
    } catch (e) {
      emit(ProfileError
        (errorMessage: e.toString()));
    }
  }

  void changeTab(int index) {
    _activeTabIndex = index;
    if (_cachedProfile != null) {
      emit(ProfileLoaded(
        profileModel: _cachedProfile!,
        activeTabIndex: _activeTabIndex,
      ));
    }
  }

  Future<void> updateProfileData({
    required String fullName,
    required String username,
    required String specialization,
    required String bio,
    required String city,
    required String country,
    required String educationStatus,
    required String university,
    required String? major,
    required String studyYear,
    required String jobTitle,
    required String? company,
    required int experienceYears,
    required String? githubUrl,
    required String? linkedinUrl,
  }) async {
    try {

      final responseModel = await service.updateUserProfile(
        fullName: fullName,
        username: username,
        specialization: specialization,
        bio: bio,
        city: city,
        country: country,
        educationStatus: educationStatus,
        university: university,
        major: major,
        studyYear: studyYear,
        jobTitle: jobTitle,
        company: company,
        experienceYears: experienceYears,
        githubUrl: githubUrl,
        linkedinUrl: linkedinUrl,
      );


      _cachedProfile = UserProfileModel(
        success: responseModel.success,
        message: responseModel.message,
        data: responseModel.userProfile,
      );

      emit(ProfileLoaded(
        profileModel: _cachedProfile!,
        activeTabIndex: _activeTabIndex,
      ));
    } catch (e) {
      emit(ProfileError(errorMessage: "Failed to update profile: ${e.toString()}"));
      if (_cachedProfile != null) {
        emit(ProfileLoaded(profileModel: _cachedProfile!, activeTabIndex: _activeTabIndex));
      }
    }
  }
}