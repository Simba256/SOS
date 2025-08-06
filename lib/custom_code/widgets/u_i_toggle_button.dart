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

// Fully opaque colors for off and on states
const _offColor = Color(0xFFDEDEDE); // Light gray, fully opaque
const _onGradient = [
  Color(0xFFFF9D86), // Light coral, fully opaque
  Color(0xFFED4523), // Dark orange-red, fully opaque
];
const _shadowOn = Color(0x66ED4523); // Shadow color with some transparency

// Animation timing for the blinking effect (unit in ms)
const int _unitMs = 250;

// SOS pattern definition (list of durations for on/off pairs)
final List<_Pulse> _sosPattern = [
  // S: dot dot dot
  _Pulse(1, 0), _Pulse(0, 1),
  _Pulse(1, 0), _Pulse(0, 1),
  _Pulse(1, 0), _Pulse(0, 3),
  // O: dash dash dash
  _Pulse(3, 0), _Pulse(0, 1),
  _Pulse(3, 0), _Pulse(0, 1),
  _Pulse(3, 0), _Pulse(0, 3),
  // S: dot dot dot
  _Pulse(1, 0), _Pulse(0, 1),
  _Pulse(1, 0), _Pulse(0, 1),
  _Pulse(1, 0), _Pulse(0, 7), // 7-unit pause before repeating
];

/// Private data class for pulses (onUnits, offUnits).
class _Pulse {
  final int onUnits;
  final int offUnits;
  const _Pulse(this.onUnits, this.offUnits);
}

class UIToggleButton extends StatefulWidget {
  const UIToggleButton({
    super.key,
    this.width,
    this.height,
    this.icon,
    this.onTap,
  });

  final double? width;
  final double? height;
  final Widget? icon;
  final VoidCallback? onTap; // Callback for when button is tapped

  @override
  State<UIToggleButton> createState() => _UIToggleButtonState();
}

class _UIToggleButtonState extends State<UIToggleButton> {
  bool _isOn = false; // Controls the visual state (off/on styling)
  bool _isAnimating = false; // true when SOS animation is active

  @override
  void dispose() {
    super.dispose();
    _cancelAnimation = true; // ensure any running loop is canceled
  }

  bool _cancelAnimation = false;

  void _handleTap() {
    // Call the external callback if provided
    if (widget.onTap != null) {
      widget.onTap!();
    }

    if (_isAnimating) {
      // Tap during animation: cancel it
      _cancelAnimation = true;
      setState(() {
        _isAnimating = false;
        _isOn = false;
      });
    } else {
      // Start animation
      setState(() {
        _isOn = true;
        _isAnimating = true;
      });
      _cancelAnimation = false;
      _startSosAnimation();
    }
  }

  Future<void> _startSosAnimation() async {
    while (mounted && !_cancelAnimation) {
      for (final pulse in _sosPattern) {
        if (_cancelAnimation) break;

        // "On" phase - show the active styling
        if (pulse.onUnits > 0) {
          setState(() => _isOn = true);
          await Future.delayed(Duration(milliseconds: pulse.onUnits * _unitMs));
        }

        if (_cancelAnimation) break;

        // "Off" phase - show the inactive styling
        setState(() => _isOn = false);
        await Future.delayed(Duration(milliseconds: pulse.offUnits * _unitMs));
      }
    }

    // Ensure we end in the off state
    if (mounted) {
      setState(() => _isOn = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width ?? 64.0;
    final h = widget.height ?? 64.0;

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isOn ? null : _offColor,
          gradient: _isOn
              ? RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: _onGradient,
                )
              : null,
          boxShadow: _isOn
              ? [
                  BoxShadow(
                    color: _shadowOn,
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
                  Icons
                      .lightbulb_rounded, // Changed from flashlight to lightbulb
                  size: 32.0,
                  color: _isOn ? Colors.white : Colors.grey[600],
                ),
        ),
      ),
    );
  }
}
