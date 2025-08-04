import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'temp_widget.dart' show TempWidget;
import 'package:flutter/material.dart';

class TempModel extends FlutterFlowModel<TempWidget> {
  ///  State fields for stateful widgets in this page.

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
