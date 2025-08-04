import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN READCONTACTS
Future<List<ReadContactsRow>> performReadContacts(
  Database database,
) {
  final query = '''
SELECT * FROM contacts;
''';
  return _readQuery(database, query, (d) => ReadContactsRow(d));
}

class ReadContactsRow extends SqliteRow {
  ReadContactsRow(Map<String, dynamic> data) : super(data);

  String get name => data['name'] as String;
  String get phone => data['phone'] as String;
  String? get photoUrl => data['photo_url'] as String?;
}

/// END READCONTACTS

/// BEGIN READPHONENUMBERS
Future<List<ReadPhoneNumbersRow>> performReadPhoneNumbers(
  Database database,
) {
  final query = '''
SELECT phone FROM contacts;
''';
  return _readQuery(database, query, (d) => ReadPhoneNumbersRow(d));
}

class ReadPhoneNumbersRow extends SqliteRow {
  ReadPhoneNumbersRow(Map<String, dynamic> data) : super(data);

  String get phone => data['phone'] as String;
}

/// END READPHONENUMBERS

/// BEGIN SEARCHCONTACTS
Future<List<SearchContactsRow>> performSearchContacts(
  Database database, {
  String? searchTerm,
}) {
  final query = '''
SELECT * FROM contacts
WHERE LOWER(name) LIKE '%' || LOWER('${searchTerm}') || '%'
   OR LOWER(phone) LIKE '%' || LOWER('${searchTerm}') || '%';

''';
  return _readQuery(database, query, (d) => SearchContactsRow(d));
}

class SearchContactsRow extends SqliteRow {
  SearchContactsRow(Map<String, dynamic> data) : super(data);

  String get name => data['name'] as String;
  String get phoneNumber => data['phone_number'] as String;
  String? get photoUrl => data['photo_url'] as String?;
}

/// END SEARCHCONTACTS
