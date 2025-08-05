import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sign_up_v2_widget.dart' show SignUpV2Widget;
import 'package:flutter/material.dart';

class SignUpV2Model extends FlutterFlowModel<SignUpV2Widget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadedImageWidgetStateSignUp = false;
  FFUploadedFile uploadedLocalFile_uploadedImageWidgetStateSignUp =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - convertImageToBase64] action in heroImage widget.
  String? uploadedUserImage;
  // State field(s) for NameField widget.
  FocusNode? nameFieldFocusNode;
  TextEditingController? nameFieldTextController;
  String? Function(BuildContext, String?)? nameFieldTextControllerValidator;
  // State field(s) for EmailField widget.
  FocusNode? emailFieldFocusNode;
  TextEditingController? emailFieldTextController;
  String? Function(BuildContext, String?)? emailFieldTextControllerValidator;
  // State field(s) for PasswordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldTextController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldTextControllerValidator;
  // State field(s) for ConfirmPasswordField widget.
  FocusNode? confirmPasswordFieldFocusNode;
  TextEditingController? confirmPasswordFieldTextController;
  late bool confirmPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordFieldVisibility = false;
    confirmPasswordFieldVisibility = false;
  }

  @override
  void dispose() {
    nameFieldFocusNode?.dispose();
    nameFieldTextController?.dispose();

    emailFieldFocusNode?.dispose();
    emailFieldTextController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldTextController?.dispose();

    confirmPasswordFieldFocusNode?.dispose();
    confirmPasswordFieldTextController?.dispose();
  }
}
