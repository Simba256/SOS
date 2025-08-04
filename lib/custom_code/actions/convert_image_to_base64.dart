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

import 'dart:convert';
import 'dart:typed_data';

Future<String?> convertImageToBase64(FFUploadedFile? imageFile) async {
  if (imageFile == null || imageFile.bytes == null) {
    print('No file or no bytes present');
    return null;
  }

  // Extract raw image bytes
  Uint8List bytes = imageFile.bytes!;
  if (bytes.isEmpty) {
    print('Empty byte array');
    return null;
  }

  // Encode bytes to Base64 string
  String base64Image = base64Encode(bytes);
  return base64Image;
}
