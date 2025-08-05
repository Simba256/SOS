import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sign_in_v2_widget.dart' show SignInV2Widget;
import 'package:flutter/material.dart';

class SignInV2Model extends FlutterFlowModel<SignInV2Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for EmailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for Passsword widget.
  FocusNode? passswordFocusNode;
  TextEditingController? passswordTextController;
  late bool passswordVisibility;
  String? Function(BuildContext, String?)? passswordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passswordVisibility = false;
  }

  @override
  void dispose() {
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passswordFocusNode?.dispose();
    passswordTextController?.dispose();
  }
}
