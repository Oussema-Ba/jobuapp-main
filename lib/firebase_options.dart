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
    apiKey: 'AIzaSyCO0U6wkO0Zcwb7ueWGMgApkVOU8QjAVI0',
    appId: '1:456988502790:web:6f7add804154fa4191cc87',
    messagingSenderId: '456988502790',
    projectId: 'jobuapp-96b99',
    authDomain: 'jobuapp-96b99.firebaseapp.com',
    storageBucket: 'jobuapp-96b99.appspot.com',
    measurementId: 'G-YMSNQJJDKF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4vfkPcEHtubEbU5jaJux6DMAPYS0KX_k',
    appId: '1:456988502790:android:6b8f491088729d1591cc87',
    messagingSenderId: '456988502790',
    projectId: 'jobuapp-96b99',
    storageBucket: 'jobuapp-96b99.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoQNGCtOSg8qPMwadSbUvBL5dOhiHeFgY',
    appId: '1:456988502790:ios:4cad5b76cef4c36a91cc87',
    messagingSenderId: '456988502790',
    projectId: 'jobuapp-96b99',
    storageBucket: 'jobuapp-96b99.appspot.com',
    iosClientId: '456988502790-vcisvhesn6sgqid7fgj7nkkh1juq80od.apps.googleusercontent.com',
    iosBundleId: 'com.example.jobuapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoQNGCtOSg8qPMwadSbUvBL5dOhiHeFgY',
    appId: '1:456988502790:ios:4cad5b76cef4c36a91cc87',
    messagingSenderId: '456988502790',
    projectId: 'jobuapp-96b99',
    storageBucket: 'jobuapp-96b99.appspot.com',
    iosClientId: '456988502790-vcisvhesn6sgqid7fgj7nkkh1juq80od.apps.googleusercontent.com',
    iosBundleId: 'com.example.jobuapp',
  );
}