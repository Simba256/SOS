import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reset_p_w_upd_widget.dart' show ResetPWUpdWidget;
import 'package:flutter/material.dart';

class ResetPWUpdModel extends FlutterFlowModel<ResetPWUpdWidget> {
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
