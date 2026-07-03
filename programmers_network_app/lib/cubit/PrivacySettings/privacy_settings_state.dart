import '../../data/models/Profile/PrivacySettingsModel.dart';


abstract class PrivacySettingsState {}

class PrivacySettingsInitial extends PrivacySettingsState {}

class PrivacySettingsLoading extends PrivacySettingsState {}


class PrivacySettingsLoaded extends PrivacySettingsState {
  final PrivacySettingsModel settings;
  PrivacySettingsLoaded({required this.settings});
}

class PrivacySettingsError extends PrivacySettingsState {
  final String errorMessage;
  PrivacySettingsError({required this.errorMessage});
}