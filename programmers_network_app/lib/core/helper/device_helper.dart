import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceHelper {
  static Future<Map<String, String>> getDeviceData() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    String deviceName = "unknown";
    String deviceId = "unknown";
    String platform = "web";

    if (kIsWeb) {
      final webInfo = await deviceInfo.webBrowserInfo;

      deviceName = "web";
      deviceId = webInfo.userAgent ?? "web";
      platform = "web";
    } else {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;

        deviceName = "android";
        deviceId = androidInfo.id;
        platform = "android";
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;

        deviceName = "ios";
        deviceId = iosInfo.identifierForVendor ?? "unknown";
        platform = "ios";
      }
    }

    return {
      "device": deviceName,
      "device_id": deviceId,
      "platform": platform,
      "app_version": packageInfo.version,
    };
  }
}
