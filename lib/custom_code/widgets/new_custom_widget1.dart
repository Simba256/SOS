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
import '/flutter_flow/custom_functions.dart';

import 'dart:math';
// import '/flutter_flow/lat_lng.dart'; // For LatLng if needed

/// Reuse your normalized placement logic
List<LatLng> getRandomPointsOutsideCircle({int count = 4}) {
  final rng = Random();
  const double radiusSquared = 0.2025;
  const double minDistSq = 0.2 * 0.2;
  final center = LatLng(0, -0.1);
  final points = <LatLng>[];

  bool farEnough(LatLng a, LatLng b) {
    final dx = a.latitude - b.latitude;
    final dy = a.longitude - b.longitude;
    return (dx * dx + dy * dy) >= minDistSq;
  }

  while (points.length < count) {
    final x = rng.nextDouble() * 2 - 1;
    final y = rng.nextDouble() * 2 - 1;
    final distSq = x * x + (y + 0.1) * (y + 0.1);
    if (distSq <= radiusSquared) continue;

    final candidate = LatLng(x, y);
    if (points.every((p) => farEnough(p, candidate))) {
      points.add(candidate);
    }
  }
  return points;
}

class NewCustomWidget1 extends StatefulWidget {
  const NewCustomWidget1({
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
  State<NewCustomWidget1> createState() => _NewCustomWidget1State();
}

class _NewCustomWidget1State extends State<NewCustomWidget1> {
  static const double _avatarSize = 60.0;
  late final List<int> _indices;
  late final List<LatLng> _positionsNorm;

  @override
  void initState() {
    super.initState();
    _indices = List<int>.generate(widget.contactNames.length, (i) => i)
      ..shuffle()
      ..length = min(widget.contactNames.length, 4);
    _positionsNorm = getRandomPointsOutsideCircle(count: _indices.length);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width ?? 0;
    final h = widget.height ?? 0;

    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        children: List.generate(_indices.length, (idx) {
          final i = _indices[idx];
          final p = _positionsNorm[idx];

          final dx = ((p.latitude + 1) / 2) * (w - _avatarSize);
          final dy = ((p.longitude + 1) / 2) * (h - _avatarSize);

          return Positioned(
            left: dx,
            top: dy,
            width: _avatarSize,
            height: _avatarSize,
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
