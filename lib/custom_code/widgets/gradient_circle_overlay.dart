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

// --- Constants for styling ---
const _onGradientB3 = [
  Color(0xB3FF9D86),
  Color(0xB3ED4523),
];
const _shadowOn40 = Color(0x66ED4523);

class GradientCircleOverlay extends StatelessWidget {
  const GradientCircleOverlay({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final w = width ?? 64.0;
    final h = height ?? 64.0;

    return Container(
      width: w,
      height: h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: _onGradientB3,
        ),
        boxShadow: [
          BoxShadow(
            color: _shadowOn40,
            blurRadius: 16,
            spreadRadius: 6,
          ),
        ],
      ),
    );
  }
}
