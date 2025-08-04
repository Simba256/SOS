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

class BlinkingSOSButton extends StatefulWidget {
  const BlinkingSOSButton({
    super.key,
    this.width,
    this.height,
    this.onPressed,
  });

  final double? width;
  final double? height;
  final Future Function()? onPressed;

  @override
  State<BlinkingSOSButton> createState() => _BlinkingSOSButtonState();
}

class _BlinkingSOSButtonState extends State<BlinkingSOSButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.transparent,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 200,
      height: widget.height ?? 200,
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return ElevatedButton(
            onPressed: () async {
              if (widget.onPressed != null) {
                await widget.onPressed!();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _colorAnimation.value ?? Colors.red,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
            ),
            child: const Text(
              'SOS',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
