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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBsRkvwNPCiJDpEvaasdw15TFRpU_XjGrM',
    appId: '1:799829303111:web:5105f25e1edcc5c32d7662',
    messagingSenderId: '799829303111',
    projectId: 'kubiot-2e990',
    authDomain: 'kubiot-2e990.firebaseapp.com',
    storageBucket: 'kubiot-2e990.appspot.com',
    measurementId: 'G-DZCM8L0CX3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDftSxmknhnGRW5Wjzyzcp2d8ZzWSpYDFM',
    appId: '1:799829303111:android:6656c0b36582fe4d2d7662',
    messagingSenderId: '799829303111',
    projectId: 'kubiot-2e990',
    storageBucket: 'kubiot-2e990.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAb3aF2Frrm5xdg2RiO7yASlTs5bBtaBUQ',
    appId: '1:799829303111:ios:c68a9de03fe63ad82d7662',
    messagingSenderId: '799829303111',
    projectId: 'kubiot-2e990',
    storageBucket: 'kubiot-2e990.appspot.com',
    iosBundleId: 'com.example.kubiot',
  );
}
