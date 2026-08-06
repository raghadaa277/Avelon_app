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
class AvatarUploading extends ProfileState {}
class AvatarUploadSuccess extends ProfileState {
  final String message;
  AvatarUploadSuccess(this.message);
}

class AvatarRemoving extends ProfileState {}
class AvatarRemoveSuccess extends ProfileState {
  final String message;
  AvatarRemoveSuccess(this.message);
}

class AvatarActionFailure extends ProfileState {
  final String message;
  AvatarActionFailure(this.message);
}
class SkillOperationLoading extends ProfileState {}
class SkillOperationSuccess extends ProfileState {
  final String message;
  SkillOperationSuccess(this.message);
}
class SkillOperationError extends ProfileState {
  final String error;
  SkillOperationError(this.error);
}