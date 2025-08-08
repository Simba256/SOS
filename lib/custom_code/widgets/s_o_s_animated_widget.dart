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

class SOSAnimatedWidget extends StatefulWidget {
  const SOSAnimatedWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<SOSAnimatedWidget> createState() => _SOSAnimatedWidgetState();
}

class _Pulse {
  final int onUnits;
  final int offUnits;
  const _Pulse(this.onUnits, this.offUnits);
}

class _SOSAnimatedWidgetState extends State<SOSAnimatedWidget> {
  static const int _unitDurationMs = 400;

  final List<_Pulse> _sosPattern = const [
    // S: dot dot dot
    _Pulse(1, 1),
    _Pulse(1, 1),
    _Pulse(1, 3),
    // O: dash dash dash
    _Pulse(3, 1),
    _Pulse(3, 1),
    _Pulse(3, 3),
    // S: dot dot dot
    _Pulse(1, 1),
    _Pulse(1, 1),
    _Pulse(1, 7),
  ];

  int _currentIndex = 0;
  bool _isOn = true;

  Color _bgColor = Colors.white;
  Color _textColor = Colors.yellow;

  @override
  void initState() {
    super.initState();
    _startFlashing();
  }

  void _startFlashing() {
    if (!mounted) return;

    final pulse = _sosPattern[_currentIndex];
    final durationUnits = _isOn ? pulse.onUnits : pulse.offUnits;

    if (durationUnits == 0) {
      _toggleState();
      _startFlashing();
      return;
    }

    final duration = Duration(milliseconds: durationUnits * _unitDurationMs);

    setState(() {
      if (_isOn) {
        _bgColor = Colors.black;
        _textColor = Colors.white;
      } else {
        _bgColor = Colors.white;
        _textColor = Colors.yellow;
      }
    });

    Future.delayed(duration, () {
      if (!mounted) return;

      if (_isOn == false) {
        _currentIndex = (_currentIndex + 1) % _sosPattern.length;
      }

      _toggleState();
      _startFlashing();
    });
  }

  void _toggleState() {
    _isOn = !_isOn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      color: _bgColor,
      child: Align(
        alignment: Alignment.topCenter, // Aligns to top of screen
        child: Padding(
          padding: const EdgeInsets.only(top: 86.0), // Reduced top padding
          child: Transform.rotate(
            angle: 90 * 3.1415926535 / 180, // rotate 90 degrees
            child: Text(
              'SOS',
              maxLines: 1, // Force single line
              overflow: TextOverflow.visible, // Don't clip if it overflows
              softWrap: false, // Prevent text wrapping
              style: TextStyle(
                fontSize: 267, // Increased from 200 to 300
                fontWeight:
                    FontWeight.w500, // Reduced boldness from bold to w500
                color: _textColor,
                letterSpacing: 8.0, // Add letter spacing for better visibility
              ),
            ),
          ),
        ),
      ),
    );
  }
}
