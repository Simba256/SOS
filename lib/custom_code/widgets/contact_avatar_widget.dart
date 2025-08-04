// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Automatic FlutterFlow imports...
import 'dart:convert';
import 'dart:typed_data';
import '/flutter_flow/custom_functions.dart' as functions;

class ContactAvatarWidget extends StatelessWidget {
  const ContactAvatarWidget({
    Key? key,
    this.width,
    this.height,
    required this.contactName,
    this.imageUrl,
    this.imageBase64, // New param
    this.fontSize,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String contactName;
  final String? imageUrl;
  final String? imageBase64; // holds Base64 string if present
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final avatarSize = width ?? 40.0;
    final textSize = fontSize ?? (avatarSize * 0.4);

    ImageProvider? provider;

    // Priority: Base64 image → Network URL → None
    if (imageBase64 != null && imageBase64!.isNotEmpty) {
      try {
        // Remove whitespace/newlines in Base64
        final cleaned = imageBase64!.replaceAll(RegExp(r'\s+'), '');
        final bytes = base64Decode(cleaned);
        print('Decoded bytes length: ${bytes.length}');
        provider = MemoryImage(bytes);
      } catch (e) {
        print('Decode error: $e');
        provider = null;
      }
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      provider = NetworkImage(imageUrl!);
    }

    return Container(
      width: avatarSize,
      height: height ?? avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (provider != null)
            ? Colors.transparent
            : functions.generateColorFromString(contactName),
        image: (provider != null)
            ? DecorationImage(
                image: provider,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: (provider == null)
          ? Center(
              child: Text(
                functions.getInitialsRobust(contactName),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
}
