import 'dart:developer';

import 'package:ktodo/constants.dart';
import 'package:ktodo/shared/app.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseProvider {
  Database db;
  String _path;
  BaseProvider({Database db}) {
    if(db != null) {
      this.db = db;
    } else {
      this.db = app.db;
    }
  }
}