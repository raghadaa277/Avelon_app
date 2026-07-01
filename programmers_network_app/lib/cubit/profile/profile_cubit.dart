import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/Profile/profile_model.dart';
import '../../data/services/profile/profile_services.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileServices profileServices;

  ProfileCubit(this.profileServices) : super(ProfileInitial());
  UserProfileModel? _cachedProfile;
  int _activeTabIndex = 0;


  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      _cachedProfile = await profileServices.getUserProfile();
      final prefs = await SharedPreferences.getInstance();
      if (_cachedProfile!.profileCompletion != null) {
        await prefs.setString(
            'profile_completion', _cachedProfile!.profileCompletion!);
      }

      emit(ProfileLoaded(
        profileModel: _cachedProfile!,
        activeTabIndex: _activeTabIndex,
      ));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
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

    emit(ProfileLoading());

    try {
      final responseModel = await profileServices.updateUserProfile(
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

      if (responseModel != null && responseModel.success) {

        await fetchProfile();
      } else {
        emit(ProfileError(
            errorMessage: "Failed to update profile: Response is empty"));
      }
    } catch (e) {
      emit(ProfileError(
          errorMessage: "Failed to update profile: ${e.toString()}"));

      if (_cachedProfile != null) {
        emit(ProfileLoaded(
            profileModel: _cachedProfile!, activeTabIndex: _activeTabIndex));
      }
    }
  }


  Future<void> updateAvatar(File imageFile) async {
    emit(AvatarUploading());
    try {
      final response = await profileServices.updateAvatar(imageFile);

      if (response != null && response.success) {
        emit(AvatarUploadSuccess(response.message));

        await fetchProfile();
      } else {
        emit(AvatarActionFailure(response?.message ?? "Failed to update avatar"));
      }
    } catch (e) {
      emit(AvatarActionFailure(e.toString()));
    }
  }


  Future<void> removeAvatar() async {
    emit(AvatarRemoving());
    try {
      final response = await profileServices.removeAvatar();

      if (response != null && response.success) {
        emit(AvatarRemoveSuccess(response.message));

        await fetchProfile();
      } else {
        emit(AvatarActionFailure(response?.message ?? "Failed to remove avatar"));
      }
    } catch (e) {
      emit(AvatarActionFailure(e.toString()));
    }
  }
}