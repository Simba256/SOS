// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geolocator/geolocator.dart';

// Fast-path location lookup for the SOS button. The default
// getCurrentUserLocation helper waits up to 15 seconds for a high-accuracy
// GPS fix, which means the user stares at a frozen screen during an
// emergency. We flip the order:
//   1. Last-known position first (returns instantly from system cache).
//   2. If no cached fix, fall back to getCurrentPosition with a SHORT
//      timeout (2.5s) — better to send the alert with no location than
//      to make the user wait.
// Returns the default LatLng on any failure rather than throwing.
Future<LatLng> fastEmergencyLocation(LatLng defaultLocation) async {
  const freshFixTimeout = Duration(milliseconds: 2500);
  // Bail out early if location services are off or permission isn't granted.
  // We don't try to request permission here — the SOS flow should not be
  // blocked by a permission dialog mid-emergency. The default location
  // is used and the SMS is still sent.
  try {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return defaultLocation;
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return defaultLocation;
    }
  } catch (_) {
    return defaultLocation;
  }

  // Step 1: last-known position. This is a synchronous-ish cache lookup;
  // typically returns in under 100ms.
  try {
    final last = await Geolocator.getLastKnownPosition();
    if (last != null && (last.latitude != 0 || last.longitude != 0)) {
      return LatLng(last.latitude, last.longitude);
    }
  } catch (_) {
    // fall through to fresh-fix attempt
  }

  // Step 2: short fresh-fix attempt. If GPS hasn't been used recently we
  // accept whatever low-accuracy reading we can get quickly. The timeout
  // is intentionally short — we'd rather send the SMS with no location
  // than hang for 10+ seconds.
  try {
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.low,
        timeLimit: freshFixTimeout,
      ),
    );
    if (pos.latitude != 0 || pos.longitude != 0) {
      return LatLng(pos.latitude, pos.longitude);
    }
  } catch (_) {
    // Either timeout or platform error — fall through to default.
  }

  return defaultLocation;
}
