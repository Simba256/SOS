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

Future<List<FinalContactStruct>?> getContacts() async {
  try {
    // Request permission to access contacts
    if (!await FlutterContacts.requestPermission()) {
      return null;
    }

    // Retrieve contacts with phone numbers
    List<Contact> contacts =
        await FlutterContacts.getContacts(withProperties: true);

    // Convert contacts to FinalContactStruct format
    List<FinalContactStruct> customContacts = contacts.map((contact) {
      final name = contact.displayName;
      final phone =
          contact.phones.isNotEmpty ? contact.phones.first.number : '';
      return FinalContactStruct(
        name: name,
        phoneNumber: phone,
        isSelected: false,
      );
    }).toList();

    return customContacts;
  } catch (e) {
    print('Error loading contacts: $e');
    return null;
  }
}
