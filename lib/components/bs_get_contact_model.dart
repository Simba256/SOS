import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bs_get_contact_widget.dart' show BsGetContactWidget;
import 'package:flutter/material.dart';

class BsGetContactModel extends FlutterFlowModel<BsGetContactWidget> {
  ///  Local state fields for this component.

  List<String> selectedNumber = [];
  void addToSelectedNumber(String item) => selectedNumber.add(item);
  void removeFromSelectedNumber(String item) => selectedNumber.remove(item);
  void removeAtIndexFromSelectedNumber(int index) =>
      selectedNumber.removeAt(index);
  void insertAtIndexInSelectedNumber(int index, String item) =>
      selectedNumber.insert(index, item);
  void updateSelectedNumberAtIndex(int index, Function(String) updateFn) =>
      selectedNumber[index] = updateFn(selectedNumber[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getContacts] action in BsGetContact widget.
  List<FinalContactStruct>? contacts2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
