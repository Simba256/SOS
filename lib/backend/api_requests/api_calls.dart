import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class TwilioSendSMSCall {
  static Future<ApiCallResponse> call({
    String? accountSid = '',
    String? authToken = '',
    String? fromNumber = '',
    String? toNumber = '',
    String? messageBody = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Twilio Send SMS',
      apiUrl:
          'https://api.twilio.com/2010-04-01/Accounts/${accountSid}/Messages.json',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic QUNkZmYxZDYwMTgyMDBlZWYxMDE1Mjg4ZWJhMTI4YmIzYjo4Y2E1MWYzZTQ2OGE0ZDdlZGFhNjRmOTM4Nzk4Y2Y4Ng==',
      },
      params: {
        'From': fromNumber,
        'To': toNumber,
        'Body': messageBody,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ReverseGeocodeCall {
  static Future<ApiCallResponse> call({
    String? latlng = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Reverse Geocode',
      apiUrl: 'https://maps.googleapis.com/maps/api/geocode/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'latlng': latlng,
        'key': "AIzaSyD7R6GPJWc08I1k_j9d0z1MlC9OIgVJMrI",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? addressString(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results[0].formatted_address''',
      ));
}

class ResetPasswordCall {
  static Future<ApiCallResponse> call({
    String? oobCode = '',
    String? newPassword = '',
    String? apiKey = 'AIzaSyCN5L-PWqF0jBUr7q8lT6UwA8KRq1smZAw',
  }) async {
    final ffApiRequestBody = '''
{
  "oobCode": "${escapeStringForJson(oobCode)}",
  "newPassword": "${escapeStringForJson(newPassword)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'resetPassword',
      apiUrl:
          'https://identitytoolkit.googleapis.com/v1/accounts:resetPassword?key=${apiKey}',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
