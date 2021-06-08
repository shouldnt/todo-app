import 'package:ktodo/DB/main.dart';
import 'package:sqflite/sqflite.dart';

class _App {
  Database db;
  static final _App app = new _App._internal();
  factory _App() {
    return app;
  }

  init() async {
    this.db = await getDb();
    return null;
  }

  _App._internal();
}

final app = new _App();

