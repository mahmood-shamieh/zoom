// ignore_for_file: file_names

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {

    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-JLsDAN4qzDk9zsuxc3vk93HsTCnFK00',
    appId: '1:258307894562:android:621b1a24c7897d7c41c97b',
    messagingSenderId: '258307894562',
    projectId: 'zoom-app-681ec',
    authDomain: 'zoom-app-681ec.firebaseapp.com',
    storageBucket: 'zoom-app-681ec.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-JLsDAN4qzDk9zsuxc3vk93HsTCnFK00',
    appId: '1:258307894562:android:2514cfc6c8abbca49058ba',
    messagingSenderId: '258307894562',
    projectId: 'zoom-app-681ec',
    storageBucket: 'zoom-app-681ec.appspot.com',
  );
}
