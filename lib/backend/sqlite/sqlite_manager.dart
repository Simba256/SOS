import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'queries/read.dart';
import 'queries/update.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'emergency_contacts',
      'contacts_extended2.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<ReadContactsRow>> readContacts() => performReadContacts(
        _database,
        userId: currentUserUid,
      );

  Future<List<ReadPhoneNumbersRow>> readPhoneNumbers() =>
      performReadPhoneNumbers(
        _database,
        userId: currentUserUid,
      );

  Future<List<SearchContactsRow>> searchContacts({
    String? searchTerm,
  }) =>
      performSearchContacts(
        _database,
        searchTerm: searchTerm,
        userId: currentUserUid,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  Future addContactNewFormat({
    String? name,
    String? phone,
    String? photo,
  }) =>
      performAddContactNewFormat(
        _database,
        name: name,
        phone: phone,
        photo: photo,
        userId: currentUserUid,
      );

  Future deleteContact({
    String? phoneNumber,
  }) =>
      performDeleteContact(
        _database,
        phoneNumber: phoneNumber,
        userId: currentUserUid,
      );

  Future addContactWithoutPhoto({
    String? name,
    String? phone,
  }) =>
      performAddContactWithoutPhoto(
        _database,
        name: name,
        phone: phone,
        userId: currentUserUid,
      );

  Future addContactOldFormat({
    String? name,
    String? phone,
    String? photo,
  }) =>
      performAddContactOldFormat(
        _database,
        name: name,
        phone: phone,
        photo: photo,
        userId: currentUserUid,
      );

  Future deleteContactWithName({
    String? name,
  }) =>
      performDeleteContactWithName(
        _database,
        name: name,
        userId: currentUserUid,
      );

  /// END UPDATE QUERY CALLS
}
