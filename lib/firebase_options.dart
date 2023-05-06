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
    apiKey: 'AIzaSyCm6TGSpphF9--bjxaVrFKYtA8U0vYKEjw',
    appId: '1:604140217322:web:874f4cd34a7e0c19dcc893',
    messagingSenderId: '604140217322',
    projectId: 'jumpinsports-a0c14',
    authDomain: 'jumpinsports-a0c14.firebaseapp.com',
    storageBucket: 'jumpinsports-a0c14.appspot.com',
    measurementId: 'G-NM44SCSSDB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALbRSswHGwmOFhoxHWla3JErM09vsx2sQ',
    appId: '1:604140217322:android:6cf96bf8b69691d9dcc893',
    messagingSenderId: '604140217322',
    projectId: 'jumpinsports-a0c14',
    storageBucket: 'jumpinsports-a0c14.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJzq4IwOS9Db2vLgncu6mWieylQHgPs9Y',
    appId: '1:604140217322:ios:9c94911ade5e4780dcc893',
    messagingSenderId: '604140217322',
    projectId: 'jumpinsports-a0c14',
    storageBucket: 'jumpinsports-a0c14.appspot.com',
    iosClientId: '604140217322-ksmbou52o2mctt02jnfoc0oee4sjtrkc.apps.googleusercontent.com',
    iosBundleId: 'com.jumpinsports.lockerRoom',
  );
}