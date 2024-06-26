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
    apiKey: 'AIzaSyA0rsSDwGWVgteYSBO8ybijp8HCmK6HUUw',
    appId: '1:1001416423277:web:1c313fd6e3a1f2191c8c64',
    messagingSenderId: '1001416423277',
    projectId: 'the-company-fcdcd',
    authDomain: 'the-company-fcdcd.firebaseapp.com',
    storageBucket: 'the-company-fcdcd.appspot.com',
    measurementId: 'G-L4WE8QG9JE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnpliIHcmokwcCxnvT79ZnNYzvevzk3U4',
    appId: '1:1001416423277:android:67a5457760717c201c8c64',
    messagingSenderId: '1001416423277',
    projectId: 'the-company-fcdcd',
    storageBucket: 'the-company-fcdcd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDt18VvYb7Whj_3db9MLGZnKCWWRsiTgl8',
    appId: '1:1001416423277:ios:2f2ccab6ee7a2fba1c8c64',
    messagingSenderId: '1001416423277',
    projectId: 'the-company-fcdcd',
    storageBucket: 'the-company-fcdcd.appspot.com',
    iosBundleId: 'com.example.theCompany',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDt18VvYb7Whj_3db9MLGZnKCWWRsiTgl8',
    appId: '1:1001416423277:ios:8ee114f8d7743c691c8c64',
    messagingSenderId: '1001416423277',
    projectId: 'the-company-fcdcd',
    storageBucket: 'the-company-fcdcd.appspot.com',
    iosBundleId: 'com.example.theCompany.RunnerTests',
  );
}
