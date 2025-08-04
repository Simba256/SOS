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

import 'index.dart'; // Imports other custom actions
import 'package:flutter_contacts/flutter_contacts.dart';
import '/app_state.dart';

Future<bool> readContacts() async {
  try {
    // Request permission
    if (!await FlutterContacts.requestPermission()) {
      return false;
    }
    // Get contacts
    final contacts = await FlutterContacts.getContacts(
        withProperties: true, withPhoto: false);
    // Map to ContactStruct
    final contactStructs = contacts
        .map((c) => ContactStruct(
              displayName: c.displayName,
              firstName: c.name.first,
              lastName: c.name.last,
              phoneNumbers: c.phones.map((p) => p.number).toList(),
              emails: c.emails.map((e) => e.address).toList(),
            ))
        .toList();
    // Set FFAppState.contacts
    FFAppState().contacts = contactStructs;
    return true;
  } catch (e) {
    print('Error reading contacts: '
        '${e.toString()}');
    return false;
  }
}
