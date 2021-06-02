import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../constants.dart';
Future<Database> getDb() async {
  String _path = join(await getDatabasesPath(), DB_NAME);
  log(_path);
  return await openDatabase(
    _path,
    onCreate: (db, int version) async {
      db.execute(
        'CREATE TABLE $tableTemplate(id INTEGER PRIMARY KEY, description TEXT, created_at TEXT)',
      );
      db.execute(
        'CREATE TABLE $tableTodo(id INTEGER PRIMARY KEY,  description TEXT, completed INTEGER, created_at TEXT)',
      );
    },
    onOpen: (db) {
    },
    version: 1
  );
}


