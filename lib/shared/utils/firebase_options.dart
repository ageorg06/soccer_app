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
    apiKey: 'AIzaSyCtzVq3h7lgC7KW07oHSw8s7ms7CW0aoOM',
    appId: '1:348572126755:web:66345eb877b556b96b2b96',
    messagingSenderId: '348572126755',
    projectId: 'soccer-app-5af3d',
    authDomain: 'soccer-app-5af3d.firebaseapp.com',
    storageBucket: 'soccer-app-5af3d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-CytIMhk7nDOUG_pmV8iyKPiTbcghTuA',
    appId: '1:348572126755:android:060884ac86dff7656b2b96',
    messagingSenderId: '348572126755',
    projectId: 'soccer-app-5af3d',
    storageBucket: 'soccer-app-5af3d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2pO1F57N8CC7xUg0f0vXZe7lIwd0xif4',
    appId: '1:348572126755:ios:403ae2f00e445fce6b2b96',
    messagingSenderId: '348572126755',
    projectId: 'soccer-app-5af3d',
    storageBucket: 'soccer-app-5af3d.appspot.com',
    iosClientId: '348572126755-cpppq8eg3mi3af0ef4990sv6mka793d0.apps.googleusercontent.com',
    iosBundleId: 'com.example.nextGenFirstApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2pO1F57N8CC7xUg0f0vXZe7lIwd0xif4',
    appId: '1:348572126755:ios:403ae2f00e445fce6b2b96',
    messagingSenderId: '348572126755',
    projectId: 'soccer-app-5af3d',
    storageBucket: 'soccer-app-5af3d.appspot.com',
    iosClientId: '348572126755-cpppq8eg3mi3af0ef4990sv6mka793d0.apps.googleusercontent.com',
    iosBundleId: 'com.example.nextGenFirstApp',
  );
}
