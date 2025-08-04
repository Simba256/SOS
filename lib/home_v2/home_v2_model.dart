import '/backend/api_requests/api_calls.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_v2_widget.dart' show HomeV2Widget;
import 'package:flutter/material.dart';

class HomeV2Model extends FlutterFlowModel<HomeV2Widget> {
  ///  Local state fields for this page.

  int selectedIndex = -1;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Reverse Geocode)] action in HomeV2 widget.
  ApiCallResponse? apiResultoru;
  // Stores action output result for [Backend Call - SQLite (ReadContacts)] action in Stack widget.
  List<ReadContactsRow>? allContacts;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
