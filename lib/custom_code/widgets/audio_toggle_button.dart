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

import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

// --- Constants for styling ---

// Fully opaque colors for off and on states
const _offColor = Color(0xFFDEDEDE); // Light gray, fully opaque
const _onGradient = [
  Color(0xFFFF9D86), // Light coral, fully opaque
  Color(0xFFED4523), // Dark orange-red, fully opaque
];
const _shadowOn = Color(0x66ED4523); // Shadow color with some transparency

class AudioToggleButton extends StatefulWidget {
  const AudioToggleButton({
    super.key,
    this.width,
    this.height,
    this.torchIcon,
  });

  final double? width;
  final double? height;
  final Widget? torchIcon;

  @override
  State<AudioToggleButton> createState() => _AudioToggleButtonState();
}

class _AudioToggleButtonState extends State<AudioToggleButton> {
  AudioPlayer? _audioPlayer;
  bool _isOn = false; // button styling state
  bool _isInitialized = false;
  String? _errorMessage;
  Uint8List? _audioData;

  @override
  void initState() {
    super.initState();
    _initializeAudio();

    // Listen to app state changes
    FFAppState().addListener(_onSOSStateChanged);
  }

  Future<void> _initializeAudio() async {
    try {
      // Create a new audio player instance
      _audioPlayer = AudioPlayer();

      // Try to load the audio file from assets using rootBundle
      // This is more reliable in FlutterFlow than AssetSource
      try {
        // Try loading directly from assets
        final ByteData data = await rootBundle.load('assets/3150Hz.mp3');
        _audioData = data.buffer.asUint8List();

        // Set the audio source from bytes
        await _audioPlayer!.setSourceBytes(_audioData!);

        print('Successfully loaded audio from assets/3150Hz.mp3');
      } catch (e) {
        print('Failed to load from assets/3150Hz.mp3: $e');

        // Try alternative paths
        try {
          final ByteData data =
              await rootBundle.load('assets/audio/3150Hz.mp3');
          _audioData = data.buffer.asUint8List();
          await _audioPlayer!.setSourceBytes(_audioData!);
          print('Successfully loaded audio from assets/audio/3150Hz.mp3');
        } catch (e2) {
          print('Failed to load from assets/audio/3150Hz.mp3: $e2');

          // Try alternative paths
          try {
            final ByteData data =
                await rootBundle.load('assets/audios/3150Hz.mp3');
            _audioData = data.buffer.asUint8List();
            await _audioPlayer!.setSourceBytes(_audioData!);
            print('Successfully loaded audio from assets/audios/3150Hz.mp3');
          } catch (e3) {
            print('Failed to load from assets/audios/3150Hz.mp3: $e3');
            // Last attempt - try without assets prefix
            try {
              final ByteData data = await rootBundle.load('3150Hz.mp3');
              _audioData = data.buffer.asUint8List();
              await _audioPlayer!.setSourceBytes(_audioData!);
              print('Successfully loaded audio from 3150Hz.mp3');
            } catch (e4) {
              print('Failed to load from 3150Hz.mp3: $e4');
              throw Exception('Could not load audio file from any path');
            }
          }
        }
      }

      // Set release mode but don't loop since we'll control it manually
      await _audioPlayer!.setReleaseMode(ReleaseMode.stop);

      setState(() {
        _isInitialized = true;
        _errorMessage = null;
      });
    } catch (e) {
      print('Error initializing audio: $e');
      setState(() {
        _isInitialized = false;
        _errorMessage = 'Could not load audio';
      });
    }
  }

  void _onSOSStateChanged() {
    // This is called immediately when FFAppState updates
    if (!mounted || !_isInitialized || _audioPlayer == null) return;

    final currentSOSState = FFAppState().currentSOSState;
    final audioEnabled = FFAppState().isAudioEnabled;

    print(
        '[AUDIO] Listener called: currentSOSState=$currentSOSState, audioEnabled=$audioEnabled at ${DateTime.now().millisecondsSinceEpoch}');

    // Only control audio if it's enabled
    if (audioEnabled) {
      try {
        if (currentSOSState) {
          // Start playing audio
          _audioPlayer!.seek(Duration.zero);
          _audioPlayer!.resume();
          print('[AUDIO] Started playing');
        } else {
          // Stop audio
          _audioPlayer!.pause();
          print('[AUDIO] Paused');
        }
      } catch (e) {
        print('[AUDIO] Error controlling audio: $e');
      }
    }
  }

  void _handleTap() {
    if (!_isInitialized || _audioPlayer == null) {
      // Try to initialize again on tap if failed
      _initializeAudio();
      return;
    }

    if (_isOn) {
      // Turn off
      _audioPlayer?.stop();
      FFAppState().isAudioEnabled = false;
      setState(() {
        _isOn = false;
      });
    } else {
      // Turn on - will follow SOS pattern automatically
      FFAppState().isAudioEnabled = true;
      setState(() {
        _isOn = true;
      });
      // Immediately sync to current state
      _onSOSStateChanged();
    }
  }

  @override
  void dispose() {
    // Remove listener and ensure audio is off
    FFAppState().removeListener(_onSOSStateChanged);
    if (_isOn) {
      _audioPlayer?.stop();
      FFAppState().isAudioEnabled = false;
    }
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width ?? 64.0;
    final h = widget.height ?? 64.0;

    // Show error state if there's an error message
    if (_errorMessage != null) {
      return GestureDetector(
        onTap: _handleTap, // Allow retry on tap
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _offColor,
          ),
          child: Center(
            child: Icon(
              Icons.error_outline,
              size: 32.0,
              color: Colors.red[400],
            ),
          ),
        ),
      );
    }

    // Show loading state while initializing
    if (!_isInitialized) {
      return Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _offColor,
        ),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Colors.grey,
          ),
        ),
      );
    }

    // Main button UI
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
        child: Align(
          alignment: Alignment(
              -0.18, 0), // Positioned at (-0.28, 0) on normalized scale
          child: widget.torchIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    size: 32.0,
                    color: _isOn ? Colors.white : Colors.grey[600],
                  ),
                  child: widget.torchIcon!,
                )
              : Icon(
                  _isOn ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 32.0,
                  color: _isOn ? Colors.white : Colors.grey[600],
                ),
        ),
      ),
    );
  }
}
