// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// / Default [FirebaseOptions] for use with your Firebase apps.
// /
// / Example:
// / ```dart
// / import 'firebase_options.dart';
// / // ...
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
// / ```
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
    apiKey: 'AIzaSyDRILTNHIbc3VBMMN_i629lMnl1RBYvOSg',
    appId: '1:696276607475:web:e0fc68ae36307333ffb286',
    messagingSenderId: '696276607475',
    projectId: 'rorich-f15d5',
    authDomain: 'rorich-f15d5.firebaseapp.com',
    storageBucket: 'rorich-f15d5.appspot.com',
    measurementId: 'G-2WP4KNTD0S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2gVw3fkanxvnfw5QgA4NZiyTCjX2Clug',
    appId: '1:696276607475:android:a1fab5afa46e8413ffb286',
    messagingSenderId: '696276607475',
    projectId: 'rorich-f15d5',
    storageBucket: 'rorich-f15d5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-AwMFFy3yk2NuION1oWS92eiOoDqTgZY',
    appId: '1:696276607475:ios:b37bf2965b78ab90ffb286',
    messagingSenderId: '696276607475',
    projectId: 'rorich-f15d5',
    storageBucket: 'rorich-f15d5.appspot.com',
    iosBundleId: 'com.example.test',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-AwMFFy3yk2NuION1oWS92eiOoDqTgZY',
    appId: '1:696276607475:ios:25a71a4df360793effb286',
    messagingSenderId: '696276607475',
    projectId: 'rorich-f15d5',
    storageBucket: 'rorich-f15d5.appspot.com',
    iosBundleId: 'com.example.test.RunnerTests',
  );
}
