import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'load_contacts_v2_widget.dart' show LoadContactsV2Widget;
import 'package:flutter/material.dart';

class LoadContactsV2Model extends FlutterFlowModel<LoadContactsV2Widget> {
  ///  Local state fields for this page.

  String? search = '';

  List<FinalContactStruct> newPhoneContacts = [];
  void addToNewPhoneContacts(FinalContactStruct item) =>
      newPhoneContacts.add(item);
  void removeFromNewPhoneContacts(FinalContactStruct item) =>
      newPhoneContacts.remove(item);
  void removeAtIndexFromNewPhoneContacts(int index) =>
      newPhoneContacts.removeAt(index);
  void insertAtIndexInNewPhoneContacts(int index, FinalContactStruct item) =>
      newPhoneContacts.insert(index, item);
  void updateNewPhoneContactsAtIndex(
          int index, Function(FinalContactStruct) updateFn) =>
      newPhoneContacts[index] = updateFn(newPhoneContacts[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getContacts] action in LoadContactsV2 widget.
  List<FinalContactStruct>? mobileContactsRead;
  // State field(s) for Checkbox widget.
  Map<FinalContactStruct, bool> checkboxValueMap = {};
  List<FinalContactStruct> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
