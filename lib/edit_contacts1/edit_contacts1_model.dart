import '/flutter_flow/flutter_flow_util.dart';
import 'edit_contacts1_widget.dart' show EditContacts1Widget;
import 'package:flutter/material.dart';

class EditContacts1Model extends FlutterFlowModel<EditContacts1Widget> {
  ///  Local state fields for this page.

  String? newContactName;

  String newContactPhone = '-1';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
