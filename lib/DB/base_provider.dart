import 'package:ktodo/shared/app.dart';
import 'package:sqflite/sqflite.dart';

class BaseProvider {
  Database db;
  BaseProvider({Database db}) {
    if(db != null) {
      this.db = db;
    } else {
      this.db = app.db;
    }
  }
}