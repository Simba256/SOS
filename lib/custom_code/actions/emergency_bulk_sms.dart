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

import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String?> _getManufacturer() async {
  const channel = MethodChannel('flutter/sms');
  try {
    return await channel.invokeMethod<String>('getManufacturer');
  } catch (_) {
    return null;
  }
}

/// Updated emergencyBulkSms function with `emergencyType` parameter.
Future emergencyBulkSms(
  List<String>? phoneList,
  LatLng? location,
  int? emergencyType,
) async {
  if (phoneList == null || phoneList.isEmpty || location == null) return;

  final lat = location.latitude;
  final lng = location.longitude;
  final mapsLink = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

  // Emergency type mapping
  const emergencyTypes = {
    -1: 'an Emergency',
    0: 'a Medical Emergency',
    1: 'a Fire Emergency',
    2: 'a Natural Disaster',
    3: 'an Accident',
    4: 'a Violent Attack',
    5: 'an Emergency, Rescue Required',
  };
  final typeText = emergencyTypes[emergencyType] ?? 'an Emergency';

  final message =
      'Hey, I am in *$typeText* at this location: ${Uri.encodeFull(mapsLink)}';

  final cleaned = phoneList
      .map((n) => n.replaceAll(RegExp(r'[^0-9\+]+'), ''))
      .where((n) => n.length >= 7)
      .toSet()
      .toList();
  if (cleaned.isEmpty) return;

  String delimiter = Platform.isAndroid ? ';' : ',';
  if (Platform.isAndroid) {
    final manu = (await _getManufacturer())?.toLowerCase() ?? '';
    if (manu.contains('samsung')) delimiter = ',';
  }

  final recipients = cleaned.join(delimiter);
  final uriStr =
      '${Platform.isIOS ? 'sms:' : 'smsto:'}$recipients?body=${Uri.encodeComponent(message)}';
  final uri = Uri.tryParse(uriStr);
  if (uri != null && await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    return;
  }

  // Fallback for individual drafts
  for (final num in cleaned) {
    final singleUri =
        Uri.tryParse('sms:$num?body=${Uri.encodeComponent(message)}');
    if (singleUri != null && await canLaunchUrl(singleUri)) {
      await launchUrl(singleUri, mode: LaunchMode.externalApplication);
    }
  }
}
