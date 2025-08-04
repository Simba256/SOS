import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'contacts_v2_widget.dart' show ContactsV2Widget;
import 'package:flutter/material.dart';

class ContactsV2Model extends FlutterFlowModel<ContactsV2Widget> {
  ///  Local state fields for this page.

  String? search = '';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - fetchPhoneContacts] action in Row widget.
  List<FinalContactStruct>? fetchedPhoneContacts;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
