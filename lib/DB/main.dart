import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../constants.dart';
Future<Database> getDb() async {
  String _path = join(await getDatabasesPath(), DB_NAME);
  log(_path);
  await deleteDatabase(_path);
  return await openDatabase(
    _path,
    onUpgrade: (db, oldVersion, newVersion) {
      log('onUpgrade');
      if(oldVersion != newVersion) {
        db.execute(
          'CREATE TABLE $tableTemplate(id INTEGER PRIMARY KEY, description TEXT, created_at TEXT, priority INTEGER)',
        );
        db.execute(
          'CREATE TABLE $tableTodo(id INTEGER PRIMARY KEY,  description TEXT, completed INTEGER, created_at TEXT, priority INTEGER)',
        );
        db.execute(
          'CREATE TABLE $tableReadingBook(id INTEGER PRIMARY KEY, name TEXT, page INTEGER, created_at TEXT, read_count INT)',
        );
      }
    },
    onCreate: (db, int version) {
      db.execute(
        'CREATE TABLE $tableTemplate(id INTEGER PRIMARY KEY, description TEXT, created_at TEXT, priority INTEGER)',
      );
      db.execute(
        'CREATE TABLE $tableTodo(id INTEGER PRIMARY KEY,  description TEXT, completed INTEGER, created_at TEXT, priority INTEGER)',
      );
      db.execute(
        'CREATE TABLE $tableReadingBook(id INTEGER PRIMARY KEY, name TEXT, mark_page INTEGER, created_at TEXT, read_count INT)',
      );
    },
    onOpen: (db) {
      // db.execute('ALTER TABLE $tableTemplate ADD COLUMN priority INTEGER');
      // db.execute('ALTER TABLE $tableTodo ADD COLUMN priority INTEGER');
    },
    version: 2
  );
}


