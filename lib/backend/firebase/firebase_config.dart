import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// SECURITY NOTICE:
// These Firebase configuration values are safe to expose in web/mobile apps as they
// identify your Firebase project to Google's servers. However, you MUST secure your
// Firebase backend with proper security rules:
//
// 1. Firestore Security Rules: Restrict read/write access based on authentication
// 2. Storage Security Rules: Validate file uploads and restrict access
// 3. Firebase Authentication: Enable only required sign-in methods
// 4. API Key Restrictions: In Firebase Console, restrict API keys by:
//    - Android app package name
//    - iOS bundle ID
//    - HTTP referrers for web
//
// Learn more: https://firebase.google.com/docs/rules

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCpFZAr7RjcmbrsRemst4ysiTTC6ifSXcs",
            authDomain: "sos-app-w.firebaseapp.com",
            projectId: "sos-app-w",
            storageBucket: "sos-app-w.firebasestorage.app",
            messagingSenderId: "244269369851",
            appId: "1:244269369851:web:df4b058fed06d74401635e",
            measurementId: "G-6054DWEMPD"));
  } else {
    await Firebase.initializeApp();
  }
}
