import 'package:intl/intl.dart';
import 'package:ktodo/DB/base_provider.dart';
import 'package:ktodo/constants.dart';
import 'package:ktodo/models/reading_book.dart';
import 'package:sqflite/sqflite.dart';

class ReadingBookProvider extends BaseProvider {
  Future<ReadingBookModel> create(ReadingBookModel book) async {
    book.id = await this.db.insert(tableReadingBook, book.toMap());
    return book;
  }

  Future<ReadingBookModel> createReadingBook(ReadingBookModel book) async {
    Batch batch = db.batch();
    batch.insert(tableReadingBook, book.toMap());
    var ids = await batch.commit();
    book.id = ids[0];
    return book;
  }

  Future<List<ReadingBookModel>> getReadingBooks() async {
    try {
      // List<Map> maps = await db.query(tableReadingBook, where: "created_at = ?", whereArgs: [dateDbFormat(date)]);
      List<Map> maps = await db.query(
        tableReadingBook,
      );

      List<ReadingBookModel> books = maps.map<ReadingBookModel>((todoMap) {
        return ReadingBookModel.fromMap(todoMap);
      }).toList();
      return books;
    } catch(error) {
      return [];
    }
  }

  Future<int> update(ReadingBookModel book) async {
    return await db.update(tableReadingBook, book.toMap(),
      where: 'id = ?', whereArgs: [book.id]);
  }
  Future<int> delete(int id) async {
    return await db.delete(tableReadingBook, where: 'id = ?', whereArgs: [id]);
  }
}