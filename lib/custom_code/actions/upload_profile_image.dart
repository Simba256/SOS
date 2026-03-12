// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/auth/firebase_auth/auth_util.dart';
import '/backend/firebase_storage/storage.dart';

/// Uploads a profile image to Firebase Storage and updates the user's
/// Firestore document with the download URL.
///
/// Returns the download URL on success, or null on failure.
Future<String?> uploadProfileImage(FFUploadedFile? imageFile) async {
  if (imageFile == null || imageFile.bytes == null || imageFile.bytes!.isEmpty) {
    print('uploadProfileImage: No file or empty bytes');
    return null;
  }

  final userId = currentUserUid;
  if (userId.isEmpty) {
    print('uploadProfileImage: No user logged in');
    return null;
  }

  try {
    // Determine file extension from the file name, default to jpg
    String extension = 'jpg';
    if (imageFile.name != null && imageFile.name!.contains('.')) {
      extension = imageFile.name!.split('.').last.toLowerCase();
    }

    // Upload to Firebase Storage at users/{userId}/profile.{ext}
    final storagePath = 'users/$userId/profile.$extension';
    final downloadUrl = await uploadData(storagePath, imageFile.bytes!);

    if (downloadUrl == null) {
      print('uploadProfileImage: Upload failed');
      return null;
    }

    // Update the user's Firestore document with the photo URL
    await currentUserReference?.update(createUsersRecordData(
      photoUrl: downloadUrl,
    ));

    print('uploadProfileImage: Success - $downloadUrl');
    return downloadUrl;
  } catch (e) {
    print('uploadProfileImage: Error - $e');
    return null;
  }
}
