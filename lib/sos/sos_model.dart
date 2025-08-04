import '/backend/api_requests/api_calls.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sos_widget.dart' show SosWidget;
import 'package:flutter/material.dart';

class SosModel extends FlutterFlowModel<SosWidget> {
  ///  Local state fields for this page.

  bool isSOSActive = false;

  LatLng? userLocation;

  List<String> phoneNumbers = [];
  void addToPhoneNumbers(String item) => phoneNumbers.add(item);
  void removeFromPhoneNumbers(String item) => phoneNumbers.remove(item);
  void removeAtIndexFromPhoneNumbers(int index) => phoneNumbers.removeAt(index);
  void insertAtIndexInPhoneNumbers(int index, String item) =>
      phoneNumbers.insert(index, item);
  void updatePhoneNumbersAtIndex(int index, Function(String) updateFn) =>
      phoneNumbers[index] = updateFn(phoneNumbers[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (ReadContacts)] action in Container widget.
  List<ReadContactsRow>? recentContacts;
  // Stores action output result for [Backend Call - SQLite (ReadPhoneNumbers)] action in Container widget.
  List<ReadPhoneNumbersRow>? userPhoneNumbers;
  // Stores action output result for [Backend Call - API (Twilio Send SMS)] action in Container widget.
  ApiCallResponse? temp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
