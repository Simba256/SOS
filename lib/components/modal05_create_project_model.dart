import '/flutter_flow/flutter_flow_util.dart';
import 'modal05_create_project_widget.dart' show Modal05CreateProjectWidget;
import 'package:flutter/material.dart';

class Modal05CreateProjectModel
    extends FlutterFlowModel<Modal05CreateProjectWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading_uploadedImageWidgetState = false;
  FFUploadedFile uploadedLocalFile_uploadedImageWidgetState =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for ContactNo widget.
  FocusNode? contactNoFocusNode;
  TextEditingController? contactNoTextController;
  String? Function(BuildContext, String?)? contactNoTextControllerValidator;
  // State field(s) for clonableURL widget.
  FocusNode? clonableURLFocusNode;
  TextEditingController? clonableURLTextController;
  String? Function(BuildContext, String?)? clonableURLTextControllerValidator;
  // Stores action output result for [Custom Action - convertImageToBase64] action in Button widget.
  String? convertedBase64Image;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    contactNoFocusNode?.dispose();
    contactNoTextController?.dispose();

    clonableURLFocusNode?.dispose();
    clonableURLTextController?.dispose();
  }
}
