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

class ContactAvatarWidget extends StatefulWidget {
  const ContactAvatarWidget({
    Key? key,
    this.width,
    this.height,
    required this.contactName,
    this.imageUrl,
    this.imageBase64,
    this.fontSize,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String contactName;
  final String? imageUrl;
  final String? imageBase64;
  final double? fontSize;

  @override
  State<ContactAvatarWidget> createState() => _ContactAvatarWidgetState();
}

class _ContactAvatarWidgetState extends State<ContactAvatarWidget> {
  Uint8List? _cachedImageBytes;
  String? _lastImageBase64;

  @override
  void initState() {
    super.initState();
    _updateImageCache();
  }

  @override
  void didUpdateWidget(ContactAvatarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageBase64 != widget.imageBase64) {
      _updateImageCache();
    }
  }

  void _updateImageCache() {
    if (widget.imageBase64 != _lastImageBase64) {
      _lastImageBase64 = widget.imageBase64;
      if (widget.imageBase64 != null && widget.imageBase64!.isNotEmpty) {
        try {
          final cleaned = widget.imageBase64!.replaceAll(RegExp(r'\s+'), '');
          _cachedImageBytes = base64Decode(cleaned);
        } catch (e) {
          _cachedImageBytes = null;
        }
      } else {
        _cachedImageBytes = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = widget.width ?? 40.0;
    final textSize = widget.fontSize ?? (avatarSize * 0.4);

    ImageProvider? provider;

    // Priority: Cached Base64 image -> Network URL -> None
    if (_cachedImageBytes != null) {
      provider = MemoryImage(_cachedImageBytes!);
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      provider = NetworkImage(widget.imageUrl!);
    }

    return Container(
      width: avatarSize,
      height: widget.height ?? avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (provider != null)
            ? Colors.transparent
            : functions.generateColorFromString(widget.contactName),
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
                functions.getInitialsRobust(widget.contactName),
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
