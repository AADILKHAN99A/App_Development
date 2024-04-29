import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteData {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteData._() : _remoteConfig = FirebaseRemoteConfig.instance; // MODIFIED

  static RemoteData? _instance; // NEW
  factory RemoteData() => _instance ??= RemoteData._(); // NEW

  // method to get parameter

  String getString(String key) => _remoteConfig.getString(key);

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 12),
        ),
      );

  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
        const {
          RemoteKeys.resumeImageLink:
              'Hey there, this message is coming from local defaults.',
        },
      );

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      print('The config has been updated.');
    } else {
      print('The config is not updated..');
    }
  }

  Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await fetchAndActivate();
  }
}

class RemoteKeys {
  static const String resumeLink = 'resume_link';
  static const String resumeImageLink = 'resumeImage_link';
}
