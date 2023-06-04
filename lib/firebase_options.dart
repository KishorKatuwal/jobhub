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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNy2lXdfj-ydzWy4zSmGPY0dEUdMgDN3E',
    appId: '1:169559773567:android:2747fc9b9e3ab6cb4b4a4a',
    messagingSenderId: '169559773567',
    projectId: 'wcclonebackend',
    storageBucket: 'wcclonebackend.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAx5PQqI0RIs8FNmsYVuQsj00DxzfscPnA',
    appId: '1:169559773567:ios:4da3204892ecaec44b4a4a',
    messagingSenderId: '169559773567',
    projectId: 'wcclonebackend',
    storageBucket: 'wcclonebackend.appspot.com',
    androidClientId: '169559773567-1ghe1u3rvvbejvcaqeqn18dfqprglcd8.apps.googleusercontent.com',
    iosClientId: '169559773567-eg8q3mgtl05g4t02ui0b1ksmgtd4oseo.apps.googleusercontent.com',
    iosBundleId: 'com.dbestech.jobhub',
  );
}
