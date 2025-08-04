import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EmergencyContactsRecord extends FirestoreRecord {
  EmergencyContactsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "contact_name" field.
  String? _contactName;
  String get contactName => _contactName ?? '';
  bool hasContactName() => _contactName != null;

  // "contact_phone" field.
  String? _contactPhone;
  String get contactPhone => _contactPhone ?? '';
  bool hasContactPhone() => _contactPhone != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  void _initializeFields() {
    _contactName = snapshotData['contact_name'] as String?;
    _contactPhone = snapshotData['contact_phone'] as String?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _email = snapshotData['email'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('emergency_contacts');

  static Stream<EmergencyContactsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EmergencyContactsRecord.fromSnapshot(s));

  static Future<EmergencyContactsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => EmergencyContactsRecord.fromSnapshot(s));

  static EmergencyContactsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EmergencyContactsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EmergencyContactsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EmergencyContactsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EmergencyContactsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EmergencyContactsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEmergencyContactsRecordData({
  String? contactName,
  String? contactPhone,
  DocumentReference? userRef,
  String? photoUrl,
  String? email,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'contact_name': contactName,
      'contact_phone': contactPhone,
      'user_ref': userRef,
      'photo_url': photoUrl,
      'email': email,
    }.withoutNulls,
  );

  return firestoreData;
}

class EmergencyContactsRecordDocumentEquality
    implements Equality<EmergencyContactsRecord> {
  const EmergencyContactsRecordDocumentEquality();

  @override
  bool equals(EmergencyContactsRecord? e1, EmergencyContactsRecord? e2) {
    return e1?.contactName == e2?.contactName &&
        e1?.contactPhone == e2?.contactPhone &&
        e1?.userRef == e2?.userRef &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.email == e2?.email;
  }

  @override
  int hash(EmergencyContactsRecord? e) => const ListEquality().hash(
      [e?.contactName, e?.contactPhone, e?.userRef, e?.photoUrl, e?.email]);

  @override
  bool isValidKey(Object? o) => o is EmergencyContactsRecord;
}
