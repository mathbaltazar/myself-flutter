// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADGBVujc_tRYFLC0QIAnlbZ_yHX0_itnY',
    appId: '1:428417596792:android:510cf5fbdf8d49ac2f9c8d',
    messagingSenderId: '428417596792',
    projectId: 'myselff-app',
    storageBucket: 'myselff-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5lyYMvz1xueVEXiP9RVFHDkn7k2tSjTo',
    appId: '1:428417596792:ios:a9a6d8273719ad0b2f9c8d',
    messagingSenderId: '428417596792',
    projectId: 'myselff-app',
    storageBucket: 'myselff-app.appspot.com',
    iosBundleId: 'com.example.flutterApplication',
  );
}