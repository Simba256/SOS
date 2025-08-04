import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
