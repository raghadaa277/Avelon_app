import '../../../../data/models/Profile/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileModel profileModel;
  final int activeTabIndex;

  ProfileLoaded({required this.profileModel, required this.activeTabIndex});
}

class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError({required this.errorMessage});
}
