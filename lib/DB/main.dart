import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
Future<Database> getDb () async {
  return openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'todo.db'),
// When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
// Run the CREATE TABLE statement on the database.
      db.execute(
        'CREATE TABLE templates(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
      );
      db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY,  description TEXT, completed INTEGER, created_at TExt)',
      );
    },
// Set the version. This executes the onCreate function and provides a
// path to perform database upgrades and downgrades.
    version: 1,
  );
}


