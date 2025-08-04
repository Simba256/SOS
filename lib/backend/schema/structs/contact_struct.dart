// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactStruct extends FFFirebaseStruct {
  ContactStruct({
    String? displayName,
    String? firstName,
    String? lastName,
    List<String>? phoneNumbers,
    List<String>? emails,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _displayName = displayName,
        _firstName = firstName,
        _lastName = lastName,
        _phoneNumbers = phoneNumbers,
        _emails = emails,
        super(firestoreUtilData);

  // "displayName" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  set displayName(String? val) => _displayName = val;

  bool hasDisplayName() => _displayName != null;

  // "firstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  // "lastName" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  // "phoneNumbers" field.
  List<String>? _phoneNumbers;
  List<String> get phoneNumbers => _phoneNumbers ?? const [];
  set phoneNumbers(List<String>? val) => _phoneNumbers = val;

  void updatePhoneNumbers(Function(List<String>) updateFn) {
    updateFn(_phoneNumbers ??= []);
  }

  bool hasPhoneNumbers() => _phoneNumbers != null;

  // "emails" field.
  List<String>? _emails;
  List<String> get emails => _emails ?? const [];
  set emails(List<String>? val) => _emails = val;

  void updateEmails(Function(List<String>) updateFn) {
    updateFn(_emails ??= []);
  }

  bool hasEmails() => _emails != null;

  static ContactStruct fromMap(Map<String, dynamic> data) => ContactStruct(
        displayName: data['displayName'] as String?,
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        phoneNumbers: getDataList(data['phoneNumbers']),
        emails: getDataList(data['emails']),
      );

  static ContactStruct? maybeFromMap(dynamic data) =>
      data is Map ? ContactStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'displayName': _displayName,
        'firstName': _firstName,
        'lastName': _lastName,
        'phoneNumbers': _phoneNumbers,
        'emails': _emails,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'displayName': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'firstName': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'lastName': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'phoneNumbers': serializeParam(
          _phoneNumbers,
          ParamType.String,
          isList: true,
        ),
        'emails': serializeParam(
          _emails,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static ContactStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContactStruct(
        displayName: deserializeParam(
          data['displayName'],
          ParamType.String,
          false,
        ),
        firstName: deserializeParam(
          data['firstName'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['lastName'],
          ParamType.String,
          false,
        ),
        phoneNumbers: deserializeParam<String>(
          data['phoneNumbers'],
          ParamType.String,
          true,
        ),
        emails: deserializeParam<String>(
          data['emails'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'ContactStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ContactStruct &&
        displayName == other.displayName &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        listEquality.equals(phoneNumbers, other.phoneNumbers) &&
        listEquality.equals(emails, other.emails);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([displayName, firstName, lastName, phoneNumbers, emails]);
}

ContactStruct createContactStruct({
  String? displayName,
  String? firstName,
  String? lastName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ContactStruct(
      displayName: displayName,
      firstName: firstName,
      lastName: lastName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ContactStruct? updateContactStruct(
  ContactStruct? contact, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    contact
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addContactStructData(
  Map<String, dynamic> firestoreData,
  ContactStruct? contact,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (contact == null) {
    return;
  }
  if (contact.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && contact.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final contactData = getContactFirestoreData(contact, forFieldValue);
  final nestedData = contactData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = contact.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getContactFirestoreData(
  ContactStruct? contact, [
  bool forFieldValue = false,
]) {
  if (contact == null) {
    return {};
  }
  final firestoreData = mapToFirestore(contact.toMap());

  // Add any Firestore field values
  contact.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getContactListFirestoreData(
  List<ContactStruct>? contacts,
) =>
    contacts?.map((e) => getContactFirestoreData(e, true)).toList() ?? [];
