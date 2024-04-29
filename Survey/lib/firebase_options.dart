// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALvmOJkD-wHZhM8cVSOjqyKPXsD8MYh7A',
    appId: '1:844007217609:web:c8693a35308305ce743018',
    messagingSenderId: '844007217609',
    projectId: 'survey-8a4cc',
    authDomain: 'survey-8a4cc.firebaseapp.com',
    storageBucket: 'survey-8a4cc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXlJdwQHdfXbM8RjqgfSbFM3C0vT7tZm4',
    appId: '1:844007217609:android:9808cf50611c333c743018',
    messagingSenderId: '844007217609',
    projectId: 'survey-8a4cc',
    storageBucket: 'survey-8a4cc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArpENomcDi9AQZ9lCR6yrW-wP_INlpZ54',
    appId: '1:844007217609:ios:aa35fc7d3c15f6f8743018',
    messagingSenderId: '844007217609',
    projectId: 'survey-8a4cc',
    storageBucket: 'survey-8a4cc.appspot.com',
    androidClientId: '844007217609-bsjngva8r3q0bs208eikheltt97f0b8n.apps.googleusercontent.com',
    iosClientId: '844007217609-lgbkdusoejao6tsp47s4bulq82mrbdml.apps.googleusercontent.com',
    iosBundleId: 'com.example.survey',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyArpENomcDi9AQZ9lCR6yrW-wP_INlpZ54',
    appId: '1:844007217609:ios:a8b6887c95fd238d743018',
    messagingSenderId: '844007217609',
    projectId: 'survey-8a4cc',
    storageBucket: 'survey-8a4cc.appspot.com',
    androidClientId: '844007217609-bsjngva8r3q0bs208eikheltt97f0b8n.apps.googleusercontent.com',
    iosClientId: '844007217609-bste5jpq8sk4eanbgf0rucibptln88jc.apps.googleusercontent.com',
    iosBundleId: 'com.example.survey.RunnerTests',
  );
}
