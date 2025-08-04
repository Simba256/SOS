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

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import '/backend/schema/structs/final_contact_struct.dart';

/// Fetches native contacts (name + first phone number), wraps them into
/// FinalContactStruct with isSelected=false.
///
/// If permission is denied, throws an exception (use try/catch).
Future<List<FinalContactStruct>> fetchPhoneContacts() async {
  final status = await Permission.contacts.status;
  if (!status.isGranted && !status.isRestricted) {
    final result = await Permission.contacts.request();
    if (!result.isGranted) {
      if (result.isPermanentlyDenied) {
        // Optionally: openAppSettings() to prompt the user
        await openAppSettings();
      }
      throw 'Contacts permission denied';
    }
  }

  final flutterContacts =
      await FlutterContacts.getContacts(withProperties: true);
  final List<FinalContactStruct> out = [];

  for (final native in flutterContacts) {
    final name = native.displayName?.trim() ?? '';
    if (name.isEmpty || native.phones.isEmpty) continue;
    final phone = native.phones.first.number.trim();
    if (phone.isEmpty) continue;

    out.add(FinalContactStruct(
      name: name,
      phoneNumber: phone,
      isSelected: false,
    ));
  }

  return out;
}
