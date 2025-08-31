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
    this.textSize,
    this.letterSpacing,
  });

  final double? width;
  final double? height;
  final double? textSize;
  final double? letterSpacing;

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
      if (FFAppState().isModeChanged) {
        _bgColor = Colors.black;
        _textColor = _isOn ? Colors.white : Colors.black;
      } else {
        _bgColor = _isOn ? Colors.black : Colors.white;
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
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    // Calculate dimensions based on orientation
    final rotatedMainAxis = isPortrait ? screenSize.height : screenSize.width;

    // Use provided values or calculate defaults
    final fontSize = widget.textSize ?? (rotatedMainAxis * 0.35);
    final letterSpace = widget.letterSpacing ?? (rotatedMainAxis * 0.01);

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      color: _bgColor,
      child: Align(
        alignment:
            const Alignment(0, -0.3), // -1 is top, 0 is center, 1 is bottom
        child: Transform.rotate(
          angle: 90 * 3.1415926535 / 180, // rotate text 90°
          child: FittedBox(
            fit: BoxFit.none, // Don't scale, just clip to intrinsic size
            alignment: Alignment.center,
            child: Container(
              // Uncomment to debug bounding box
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.red, width: 2),
              // ),
              transform: Matrix4.translationValues(-fontSize * 0.05, 0, 0),
              child: Text(
                'SOS',
                maxLines: 1,
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: _textColor,
                  letterSpacing: letterSpace,
                  height: 1.0,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
