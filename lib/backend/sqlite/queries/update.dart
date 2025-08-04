import 'package:sqflite/sqflite.dart';

/// BEGIN ADDCONTACTNEWFORMAT
Future performAddContactNewFormat(
  Database database, {
  String? name,
  String? phone,
  String? photo,
}) {
  final query = '''
INSERT INTO contacts (name, phone, photo_url)
VALUES (:name, :phone, :photo);

''';
  return database.rawQuery(query);
}

/// END ADDCONTACTNEWFORMAT

/// BEGIN DELETE CONTACT
Future performDeleteContact(
  Database database, {
  String? phoneNumber,
}) {
  final query = '''
DELETE FROM contacts WHERE phone = '${phoneNumber}';
''';
  return database.rawQuery(query);
}

/// END DELETE CONTACT

/// BEGIN ADDCONTACTWITHOUTPHOTO
Future performAddContactWithoutPhoto(
  Database database, {
  String? name,
  String? phone,
}) {
  final query = '''
INSERT INTO contacts (name, phone) VALUES ('${name}', '${phone}');
''';
  return database.rawQuery(query);
}

/// END ADDCONTACTWITHOUTPHOTO

/// BEGIN ADDCONTACTOLDFORMAT
Future performAddContactOldFormat(
  Database database, {
  String? name,
  String? phone,
  String? photo,
}) {
  final query = '''
INSERT INTO contacts (name, phone, photo_url) VALUES ('${name}', '${phone}', '${photo}');
''';
  return database.rawQuery(query);
}

/// END ADDCONTACTOLDFORMAT

/// BEGIN DELETE CONTACTWITHNAME
Future performDeleteContactWithName(
  Database database, {
  String? name,
}) {
  final query = '''
DELETE FROM contacts WHERE name = '${name}';
''';
  return database.rawQuery(query);
}

/// END DELETE CONTACTWITHNAME
