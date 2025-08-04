import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reset_p_w_widget.dart' show ResetPWWidget;
import 'package:flutter/material.dart';

class ResetPWModel extends FlutterFlowModel<ResetPWWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
