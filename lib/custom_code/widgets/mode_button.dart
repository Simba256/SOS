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

class ModeButton extends StatefulWidget {
  const ModeButton({
    super.key,
    this.width,
    this.height,
    this.icon,
  });

  final double? width;
  final double? height;
  final Widget? icon;

  @override
  State<ModeButton> createState() => _ModeButtonState();
}

class _ModeButtonState extends State<ModeButton> {
  bool _isOn = false;

  void _toggleMode() {
    setState(() {
      _isOn = !_isOn;
      FFAppState().isModeChanged = _isOn; // update app state
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width ?? 64.0;
    final h = widget.height ?? 64.0;

    // Colors and shadow
    const offColor = Color(0xFFDEDEDE);
    const onGradient = [
      Color(0xFFFF9D86),
      Color(0xFFED4523),
    ];
    const shadowOn = Color(0x66ED4523);

    return GestureDetector(
      onTap: _toggleMode,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !_isOn ? offColor : null,
          gradient: _isOn
              ? RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: onGradient,
                )
              : null,
          boxShadow: _isOn
              ? [
                  BoxShadow(
                    color: shadowOn,
                    blurRadius: 16,
                    spreadRadius: 6,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: widget.icon != null
              ? IconTheme(
                  data: IconThemeData(
                    size: 32.0,
                    color: _isOn ? Colors.white : Colors.grey[600],
                  ),
                  child: widget.icon!,
                )
              : Icon(
                  Icons.light_mode_rounded,
                  size: 32.0,
                  color: _isOn ? Colors.white : Colors.grey[600],
                ),
        ),
      ),
    );
  }
}
