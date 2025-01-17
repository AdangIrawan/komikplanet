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
        return windows;
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
    apiKey: 'AIzaSyBQOH3JhAxR4GktgyXgqeJ1KEJZ6nUfIg8',
    appId: '1:867028664180:web:ce512c23e21ec57e3a7621',
    messagingSenderId: '867028664180',
    projectId: 'komikplanet-646dc',
    authDomain: 'komikplanet-646dc.firebaseapp.com',
    storageBucket: 'komikplanet-646dc.appspot.com',
    measurementId: 'G-L2HDK7X9TQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD82oft0EYtOeX1j5aeSO7QU4Iq1PS-45Y',
    appId: '1:867028664180:android:768ef7549c536c923a7621',
    messagingSenderId: '867028664180',
    projectId: 'komikplanet-646dc',
    storageBucket: 'komikplanet-646dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCtWxyA0YvXBs-XW7Bxxe_Fs_7caFZ0Wco',
    appId: '1:867028664180:ios:7d97ade2e41276863a7621',
    messagingSenderId: '867028664180',
    projectId: 'komikplanet-646dc',
    storageBucket: 'komikplanet-646dc.appspot.com',
    iosBundleId: 'com.example.komikplanet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCtWxyA0YvXBs-XW7Bxxe_Fs_7caFZ0Wco',
    appId: '1:867028664180:ios:7d97ade2e41276863a7621',
    messagingSenderId: '867028664180',
    projectId: 'komikplanet-646dc',
    storageBucket: 'komikplanet-646dc.appspot.com',
    iosBundleId: 'com.example.komikplanet',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBQOH3JhAxR4GktgyXgqeJ1KEJZ6nUfIg8',
    appId: '1:867028664180:web:799525a96a6883f83a7621',
    messagingSenderId: '867028664180',
    projectId: 'komikplanet-646dc',
    authDomain: 'komikplanet-646dc.firebaseapp.com',
    storageBucket: 'komikplanet-646dc.appspot.com',
    measurementId: 'G-Y41Z9ENWN2',
  );
}
