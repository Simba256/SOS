import 'dart:io';

import 'package:flutter/services.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initializeDatabaseFromDbFile(
  String databaseName,
  String databaseAssetFilename,
) async {
  final databasesPath = await getDatabasesPath();
  final path = '$databaseName.db';
  final databasePath = join(databasesPath, path);
  // First, check if the database exists.
  final exists = await databaseExists(databasePath);
  if (!exists) {
    // Ensure parent directory exists.
    try {
      await Directory(dirname(databasePath)).create(recursive: true);
    } catch (_) {}
    // Copy the database file over to the working database directory.
    final databaseData = await rootBundle
        .load(join('assets', 'sqlite_db_files', databaseAssetFilename));
    final databaseBytes = databaseData.buffer.asUint8List(
      databaseData.offsetInBytes,
      databaseData.lengthInBytes,
    );
    await File(databasePath).writeAsBytes(databaseBytes, flush: true);
  }
  // Initialize the SQLite database with migration support.
  final database = await openDatabase(
    databasePath,
    version: 2,
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Delete existing contacts (clean slate for user isolation)
        await db.execute('DELETE FROM contacts');
        // Add user_id column for multi-user data isolation
        await db.execute(
            'ALTER TABLE contacts ADD COLUMN user_id TEXT NOT NULL DEFAULT ""');
      }
    },
  );
  return database;
}
