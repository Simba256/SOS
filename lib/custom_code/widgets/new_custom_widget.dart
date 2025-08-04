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

import '/custom_code/widgets/index.dart'; // Custom widgets
import '/custom_code/actions/index.dart'; // Custom actions
import '/flutter_flow/custom_functions.dart'; // Custom functions

import 'dart:math';

class NewCustomWidget extends StatefulWidget {
  const NewCustomWidget({
    Key? key,
    this.width,
    this.height,
    required this.contactNames,
    this.contactImages,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<String> contactNames;
  final List<String>? contactImages;

  @override
  _NewCustomWidgetState createState() => _NewCustomWidgetState();
}

class _NewCustomWidgetState extends State<NewCustomWidget> {
  static const double _avatarSize = 60.0;
  late final List<int> _selectedIndices;
  late final List<Offset> _positions;

  @override
  void initState() {
    super.initState();

    final count = widget.contactNames.length;
    final indices = List<int>.generate(count, (i) => i);
    indices.shuffle(Random());
    _selectedIndices = indices.take(min(count, 4)).toList();

    _positions = _selectedIndices.map((_) {
      final maxX = (widget.width ?? 0) - _avatarSize;
      final maxY = (widget.height ?? 0) - _avatarSize;
      return Offset(
        Random().nextDouble() * (maxX > 0 ? maxX : 0),
        Random().nextDouble() * (maxY > 0 ? maxY : 0),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: List.generate(_selectedIndices.length, (idx) {
          final i = _selectedIndices[idx];
          final pos = _positions[idx];
          return Positioned(
            left: pos.dx,
            top: pos.dy,
            child: ContactAvatarWidget(
              width: _avatarSize,
              height: _avatarSize,
              contactName: widget.contactNames[i],
              imageBase64: (widget.contactImages?.length ?? 0) > i
                  ? widget.contactImages![i]
                  : null,
              fontSize: _avatarSize * 0.4,
            ),
          );
        }),
      ),
    );
  }
}
