import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_contacts_widget.dart' show MyContactsWidget;
import 'package:flutter/material.dart';

class MyContactsModel extends FlutterFlowModel<MyContactsWidget> {
  ///  Local state fields for this page.

  String? search = '';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
