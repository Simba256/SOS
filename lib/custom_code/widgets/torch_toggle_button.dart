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

import 'package:torch_light/torch_light.dart';

// --- Constants for styling ---

// Fully opaque colors for off and on states
const _offColor = Color(0xFFDEDEDE); // Light gray, fully opaque
const _onGradient = [
  Color(0xFFFF9D86), // Light coral, fully opaque
  Color(0xFFED4523), // Dark orange-red, fully opaque
];
const _shadowOn = Color(0x66ED4523); // Shadow color with some transparency

class TorchToggleButton extends StatefulWidget {
  const TorchToggleButton({
    super.key,
    this.width,
    this.height,
    this.torchIcon,
  });

  final double? width;
  final double? height;
  final Widget? torchIcon;

  @override
  State<TorchToggleButton> createState() => _TorchToggleButtonState();
}

class _TorchToggleButtonState extends State<TorchToggleButton> {
  bool _hasTorch = false;
  bool _isOn = false; // button styling state

  @override
  void initState() {
    super.initState();
    // Check availability once at startup
    TorchLight.isTorchAvailable().then((a) {
      if (mounted) setState(() => _hasTorch = a);
    }).catchError((_) {
      if (mounted) setState(() => _hasTorch = false);
    });

    // Listen to app state changes
    FFAppState().addListener(_onSOSStateChanged);
  }

  @override
  void dispose() {
    // Remove listener and ensure torch is off
    FFAppState().removeListener(_onSOSStateChanged);
    if (_isOn) {
      TorchLight.disableTorch();
      FFAppState().isTorchEnabled = false;
    }
    super.dispose();
  }

  void _onSOSStateChanged() {
    // This is called immediately when FFAppState updates
    if (!mounted || !_hasTorch) return;

    final currentSOSState = FFAppState().currentSOSState;
    final torchEnabled = FFAppState().isTorchEnabled;

    print(
        '[TORCH] Listener called: currentSOSState=$currentSOSState, torchEnabled=$torchEnabled at ${DateTime.now().millisecondsSinceEpoch}');

    // Only control torch if it's enabled
    if (torchEnabled) {
      try {
        if (currentSOSState) {
          TorchLight.enableTorch();
          print('[TORCH] Enabled torch');
        } else {
          TorchLight.disableTorch();
          print('[TORCH] Disabled torch');
        }
      } catch (e) {
        print('[TORCH] Error: $e');
      }
    }
  }

  void _handleTap() {
    if (!_hasTorch) return;

    if (_isOn) {
      // Turn off
      TorchLight.disableTorch();
      FFAppState().isTorchEnabled = false;
      setState(() {
        _isOn = false;
      });
    } else {
      // Turn on - will follow SOS pattern automatically
      FFAppState().isTorchEnabled = true;
      setState(() {
        _isOn = true;
      });
      // Immediately sync to current state
      _onSOSStateChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasTorch) {
      return const Text('No flashlight available');
    }
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
          child: widget.torchIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    size: 32.0,
                    color: _isOn ? Colors.white : Colors.grey[600],
                  ),
                  child: widget.torchIcon!,
                )
              : Icon(
                  Icons.flashlight_on_rounded,
                  size: 32.0,
                  color: _isOn ? Colors.white : Colors.grey[600],
                ),
        ),
      ),
    );
  }
}
