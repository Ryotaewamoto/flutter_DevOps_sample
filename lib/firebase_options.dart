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
    apiKey: 'AIzaSyBNX3ixTT5QvtcZCMQ0z8e0EYIyua5x3Uo',
    appId: '1:999119847904:web:ad4b0c7acb12884851ab85',
    messagingSenderId: '999119847904',
    projectId: 'flutter-devops-sample',
    authDomain: 'flutter-devops-sample.firebaseapp.com',
    storageBucket: 'flutter-devops-sample.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWP7ZRcXRenDpmnT6M0JYAbjbX_T7ItOI',
    appId: '1:999119847904:android:6b242abadc4a425051ab85',
    messagingSenderId: '999119847904',
    projectId: 'flutter-devops-sample',
    storageBucket: 'flutter-devops-sample.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBw9Qm0GrmrUu9CiFNNkt5qzhxKOVOIjD4',
    appId: '1:999119847904:ios:ae99050f8f21126851ab85',
    messagingSenderId: '999119847904',
    projectId: 'flutter-devops-sample',
    storageBucket: 'flutter-devops-sample.appspot.com',
    iosClientId:
        '999119847904-iuarmpq2hbcqek9kl46gtg3sfmhh1r32.apps.googleusercontent.com',
    iosBundleId: 'com.ryotaiwamoto.flutterDevopsSample',
  );
}
