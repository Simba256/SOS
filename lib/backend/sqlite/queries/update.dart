import 'package:sqflite/sqflite.dart';

/// BEGIN ADDCONTACTNEWFORMAT
Future performAddContactNewFormat(
  Database database, {
  String? name,
  String? phone,
  String? photo,
  required String userId,
}) {
  return database.rawInsert(
    'INSERT INTO contacts (name, phone, photo_url, user_id) VALUES (?, ?, ?, ?)',
    [name, phone, photo, userId],
  );
}

/// END ADDCONTACTNEWFORMAT

/// BEGIN DELETE CONTACT
Future performDeleteContact(
  Database database, {
  String? phoneNumber,
  required String userId,
}) {
  return database.rawDelete(
    'DELETE FROM contacts WHERE phone = ? AND user_id = ?',
    [phoneNumber, userId],
  );
}

/// END DELETE CONTACT

/// BEGIN ADDCONTACTWITHOUTPHOTO
Future performAddContactWithoutPhoto(
  Database database, {
  String? name,
  String? phone,
  required String userId,
}) {
  return database.rawInsert(
    'INSERT INTO contacts (name, phone, user_id) VALUES (?, ?, ?)',
    [name, phone, userId],
  );
}

/// END ADDCONTACTWITHOUTPHOTO

/// BEGIN ADDCONTACTOLDFORMAT
Future performAddContactOldFormat(
  Database database, {
  String? name,
  String? phone,
  String? photo,
  required String userId,
}) {
  return database.rawInsert(
    'INSERT INTO contacts (name, phone, photo_url, user_id) VALUES (?, ?, ?, ?)',
    [name, phone, photo, userId],
  );
}

/// END ADDCONTACTOLDFORMAT

/// BEGIN DELETE CONTACTWITHNAME
Future performDeleteContactWithName(
  Database database, {
  String? name,
  required String userId,
}) {
  return database.rawDelete(
    'DELETE FROM contacts WHERE name = ? AND user_id = ?',
    [name, userId],
  );
}

/// END DELETE CONTACTWITHNAME
