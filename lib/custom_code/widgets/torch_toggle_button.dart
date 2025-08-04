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

// --- Constants for tree-shaking and styling ---

// Semi-transparent overlay colors: off = ~50%, on = ~70%
const _offColor88 = Color(0x88DEDEDE);
const _onGradientB3 = [
  Color(0xB3FF9D86),
  Color(0xB3ED4523),
];
const _shadowOn40 = Color(0x66ED4523);

// Morse code timing (unit in ms). Dot = 1×unit, dash = 3×unit.
const int _unitMs = 250;

// SOS pattern definition (list of durations for on/off pairs)
final List<_Pulse> _sPattern = [
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

class TorchToggleButton extends StatefulWidget {
  const TorchToggleButton({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<TorchToggleButton> createState() => _TorchToggleButtonState();
}

class _TorchToggleButtonState extends State<TorchToggleButton> {
  bool _hasTorch = false;
  bool _isOn = false; // “steady on” or SOS mode (just controls styling)
  bool _isSosMode = false; // true when SOS blinking is active

  @override
  void initState() {
    super.initState();
    // Check availability once at startup
    TorchLight.isTorchAvailable().then((a) {
      if (mounted) setState(() => _hasTorch = a);
    }).catchError((_) {
      if (mounted) setState(() => _hasTorch = false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cancelSos = true; // ensure any running loop is canceled
  }

  bool _cancelSos = false;

  void _handleTap() {
    if (!_hasTorch) return;

    if (_isSosMode) {
      // Tap during SOS mode: cancel it
      _cancelSos = true;
      TorchLight.disableTorch(); // turn off immediately
      setState(() {
        _isSosMode = false;
        _isOn = false;
      });
    } else {
      // Enter SOS mode
      setState(() {
        _isOn = true;
        _isSosMode = true;
      });
      _cancelSos = false;
      _startSosLoop();
    }
  }

  Future<void> _startSosLoop() async {
    while (mounted && !_cancelSos) {
      for (final p in _sPattern) {
        if (_cancelSos) break;
        if (p.onUnits > 0) {
          await TorchLight.enableTorch();
          await Future.delayed(Duration(milliseconds: p.onUnits * _unitMs));
        }
        if (_cancelSos) break;
        await TorchLight.disableTorch();
        await Future.delayed(Duration(milliseconds: p.offUnits * _unitMs));
      }
    }
    await TorchLight.disableTorch();
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
          color: _isOn ? null : _offColor88,
          gradient: _isOn
              ? const RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: _onGradientB3,
                )
              : null,
          boxShadow: _isOn
              ? const [
                  BoxShadow(
                    color: _shadowOn40,
                    blurRadius: 16,
                    spreadRadius: 6,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
