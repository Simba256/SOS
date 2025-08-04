// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FinalContactStruct extends FFFirebaseStruct {
  FinalContactStruct({
    String? name,
    String? phoneNumber,
    bool? isSelected,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _phoneNumber = phoneNumber,
        _isSelected = isSelected,
        super(firestoreUtilData);

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "PhoneNumber" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "isSelected" field.
  bool? _isSelected;
  bool get isSelected => _isSelected ?? false;
  set isSelected(bool? val) => _isSelected = val;

  bool hasIsSelected() => _isSelected != null;

  static FinalContactStruct fromMap(Map<String, dynamic> data) =>
      FinalContactStruct(
        name: data['Name'] as String?,
        phoneNumber: data['PhoneNumber'] as String?,
        isSelected: data['isSelected'] as bool?,
      );

  static FinalContactStruct? maybeFromMap(dynamic data) => data is Map
      ? FinalContactStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Name': _name,
        'PhoneNumber': _phoneNumber,
        'isSelected': _isSelected,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Name': serializeParam(
          _name,
          ParamType.String,
        ),
        'PhoneNumber': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),
        'isSelected': serializeParam(
          _isSelected,
          ParamType.bool,
        ),
      }.withoutNulls;

  static FinalContactStruct fromSerializableMap(Map<String, dynamic> data) =>
      FinalContactStruct(
        name: deserializeParam(
          data['Name'],
          ParamType.String,
          false,
        ),
        phoneNumber: deserializeParam(
          data['PhoneNumber'],
          ParamType.String,
          false,
        ),
        isSelected: deserializeParam(
          data['isSelected'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'FinalContactStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FinalContactStruct &&
        name == other.name &&
        phoneNumber == other.phoneNumber &&
        isSelected == other.isSelected;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, phoneNumber, isSelected]);
}

FinalContactStruct createFinalContactStruct({
  String? name,
  String? phoneNumber,
  bool? isSelected,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FinalContactStruct(
      name: name,
      phoneNumber: phoneNumber,
      isSelected: isSelected,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FinalContactStruct? updateFinalContactStruct(
  FinalContactStruct? finalContact, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    finalContact
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFinalContactStructData(
  Map<String, dynamic> firestoreData,
  FinalContactStruct? finalContact,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (finalContact == null) {
    return;
  }
  if (finalContact.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && finalContact.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final finalContactData =
      getFinalContactFirestoreData(finalContact, forFieldValue);
  final nestedData =
      finalContactData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = finalContact.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFinalContactFirestoreData(
  FinalContactStruct? finalContact, [
  bool forFieldValue = false,
]) {
  if (finalContact == null) {
    return {};
  }
  final firestoreData = mapToFirestore(finalContact.toMap());

  // Add any Firestore field values
  finalContact.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFinalContactListFirestoreData(
  List<FinalContactStruct>? finalContacts,
) =>
    finalContacts?.map((e) => getFinalContactFirestoreData(e, true)).toList() ??
    [];
