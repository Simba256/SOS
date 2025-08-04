import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_v2_widget.dart' show ProfileV2Widget;
import 'package:flutter/material.dart';

class ProfileV2Model extends FlutterFlowModel<ProfileV2Widget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadData06v = false;
  FFUploadedFile uploadedLocalFile_uploadData06v =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - convertImageToBase64] action in ContactAvatarWidget widget.
  String? recentlyUploadedImage;
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
