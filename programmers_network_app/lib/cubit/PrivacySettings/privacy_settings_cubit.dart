import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/Profile/PrivacySettingsModel.dart';
import 'privacy_settings_state.dart';

import '../../../data/services/profile/profile_services.dart';

class PrivacySettingsCubit extends Cubit<PrivacySettingsState> {
  final ProfileServices _services;

  PrivacySettingsCubit({required ProfileServices services})
      : _services = services,
        super(PrivacySettingsInitial());


  Future<void> fetchSettings() async {
    emit(PrivacySettingsLoading());
    try {
      final responseMap = await _services.getPrivacySettings();

      if (responseMap != null && responseMap['success'] == true) {

        final settings = PrivacySettingsModel.fromJson(responseMap);
        emit(PrivacySettingsLoaded(settings: settings));
      } else {
        emit(PrivacySettingsError(
          errorMessage: responseMap?['message'] ?? "Failed to load privacy settings",
        ));
      }
    } catch (e) {
      emit(PrivacySettingsError(errorMessage: e.toString()));
    }
  }

  Future<void> updateSingleSetting(String key, dynamic value) async {
    try {

      final Map<String, dynamic> bodyData = {
        "key": key,
        "value": value,
      };


      final isSuccess = await _services.updatePrivacySettings(bodyData);

      if (!isSuccess) {
        emit(PrivacySettingsError(errorMessage: "Failed to update $key"));
      }
    } catch (e) {
      emit(PrivacySettingsError(errorMessage: e.toString()));
    }
  }
}


