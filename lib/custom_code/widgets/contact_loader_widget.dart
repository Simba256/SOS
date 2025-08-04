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

import '/custom_code/actions/index.dart'; // Imports other custom actions

// You need to add these dependencies to your project:
// permission_handler: ^10.2.0
// flutter_contacts: ^1.1.7+1
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactLoaderWidget extends StatefulWidget {
  const ContactLoaderWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ContactLoaderWidget> createState() => _ContactLoaderWidgetState();
}

class _ContactLoaderWidgetState extends State<ContactLoaderWidget> {
  List<Contact> _contacts = [];
  bool _permissionDenied = false;
  bool _isLoading = true;
  Set<String> _selectedContactIds = {};

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    // Request permission to access contacts.
    if (await Permission.contacts.request().isGranted) {
      // If permission is granted, fetch the contacts.
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        _contacts = contacts;
        _isLoading = false;
      });
    } else {
      // If permission is denied, update the state to show a message.
      setState(() {
        _permissionDenied = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleCheckboxChanged(bool? value, Contact contact) async {
    final String contactId = contact.id;
    final String name = contact.displayName;
    final String phone =
        contact.phones.isNotEmpty ? contact.phones.first.number : 'N/A';

    setState(() {
      if (value == true) {
        _selectedContactIds.add(contactId);

        // [CORRECTED CODE]
        // This now calls the function with the correct camelCase name
        // that FlutterFlow generates from your named query.
        SQLiteManager.instance.addContactWithoutPhoto(
          name: name,
          phone: phone,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$name added to emergency contacts.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        _selectedContactIds.remove(contactId);
        // Optional: You could add logic here to remove the contact from the database
        // For now, we just add and don't remove.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_permissionDenied) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Permission Denied',
                style: FlutterFlowTheme.of(context).headlineSmall,
              ),
              SizedBox(height: 8),
              Text(
                'To load contacts, please grant permission in your phone settings.',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await openAppSettings();
                },
                child: Text('Open Settings'),
              ),
            ],
          ),
        ),
      );
    }

    if (_contacts.isEmpty) {
      return Center(
        child: Text(
          'No contacts found on this device.',
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        Contact contact = _contacts[index];
        // We only want to display contacts that have a name and a phone number.
        if (contact.displayName.isEmpty || contact.phones.isEmpty) {
          return SizedBox.shrink(); // Return an empty widget if no name/phone
        }
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              child: Text(
                contact.displayName.isNotEmpty ? contact.displayName[0] : '',
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(contact.displayName),
            subtitle: Text(contact.phones.first.number),
            trailing: Checkbox(
              value: _selectedContactIds.contains(contact.id),
              onChanged: (bool? value) =>
                  _handleCheckboxChanged(value, contact),
              activeColor: FlutterFlowTheme.of(context).primary,
            ),
          ),
        );
      },
    );
  }
}
