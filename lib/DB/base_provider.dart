import 'dart:developer';

import 'package:ktodo/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseProvider {

  Database db;
  String _path;

  open() async {
    _path = join(await getDatabasesPath(), DB_NAME);
    log(_path);
    db = await openDatabase(
      _path,
      onCreate: (db, int version) {
        db.execute(
          'CREATE TABLE $tableTemplate(id INTEGER PRIMARY KEY, description TEXT, deleted INTEGER)',
        );
        db.execute(
          'CREATE TABLE $tableTodo(id INTEGER PRIMARY KEY,  description TEXT, completed INTEGER, created_at TEXT)',
        );
      },
      version: 1
    );
  }

  close() async {
    await db.close();
  }

}