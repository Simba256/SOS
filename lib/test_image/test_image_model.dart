import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'test_image_widget.dart' show TestImageWidget;
import 'package:flutter/material.dart';

class TestImageModel extends FlutterFlowModel<TestImageWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataSoi = false;
  FFUploadedFile uploadedLocalFile_uploadDataSoi =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - convertImageToBase64] action in Image widget.
  String? base64Image;
  // Stores action output result for [Backend Call - SQLite (ReadContacts)] action in CircleImage widget.
  List<ReadContactsRow>? contactsFromDB;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
