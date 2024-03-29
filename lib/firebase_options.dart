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
    apiKey: 'AIzaSyCFjck8H8jL7XmZYQBciBk4I6Cf6TSd8Kk',
    appId: '1:912233290096:web:d2d35b715becb58f71d7b5',
    messagingSenderId: '912233290096',
    projectId: 'resithon-d6e40',
    authDomain: 'resithon-d6e40.firebaseapp.com',
    databaseURL: 'https://resithon-d6e40-default-rtdb.firebaseio.com',
    storageBucket: 'resithon-d6e40.appspot.com',
    measurementId: 'G-HXG7Q0K8C9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeAvtNV7K7-Mmc2zXX1unNR0v3SiEXheE',
    appId: '1:912233290096:android:04580c39088dfcab71d7b5',
    messagingSenderId: '912233290096',
    projectId: 'resithon-d6e40',
    databaseURL: 'https://resithon-d6e40-default-rtdb.firebaseio.com',
    storageBucket: 'resithon-d6e40.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwD1Gi1PbG6eLXSsZusBVVAHfi46yo-po',
    appId: '1:912233290096:ios:af0e7acc31cadfc371d7b5',
    messagingSenderId: '912233290096',
    projectId: 'resithon-d6e40',
    databaseURL: 'https://resithon-d6e40-default-rtdb.firebaseio.com',
    storageBucket: 'resithon-d6e40.appspot.com',
    iosBundleId: 'com.yahalaaevent.yahalaa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwD1Gi1PbG6eLXSsZusBVVAHfi46yo-po',
    appId: '1:912233290096:ios:d064d55f10eb81af71d7b5',
    messagingSenderId: '912233290096',
    projectId: 'resithon-d6e40',
    databaseURL: 'https://resithon-d6e40-default-rtdb.firebaseio.com',
    storageBucket: 'resithon-d6e40.appspot.com',
    iosBundleId: 'com.yahalaaevent.yahalaa.RunnerTests',
  );
}
