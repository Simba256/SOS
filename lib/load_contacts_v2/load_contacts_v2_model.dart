import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'load_contacts_v2_widget.dart' show LoadContactsV2Widget;
import 'package:flutter/material.dart';

class LoadContactsV2Model extends FlutterFlowModel<LoadContactsV2Widget> {
  ///  Local state fields for this page.

  String? search = '';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - readContacts] action in LoadContactsV2 widget.
  bool? contactReadOutput;
  // State field(s) for Checkbox widget.
  Map<FinalContactStruct, bool> checkboxValueMap = {};
  List<FinalContactStruct> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
