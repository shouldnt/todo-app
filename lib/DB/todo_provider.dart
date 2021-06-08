import 'package:intl/intl.dart';
import 'package:ktodo/DB/base_provider.dart';
import 'package:ktodo/constants.dart';
import 'package:ktodo/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoProvider extends BaseProvider {
  Future<TodoModel> create(TodoModel todo) async {
    todo.id = await this.db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<List<TodoModel>> createTodos(List<TodoModel> todos) async {
    Batch batch = db.batch();
    for(int i = 0; i < todos.length; i++) {
      batch.insert(tableTodo, todos[i].toMap());
    }
    var ids = await batch.commit();
    for(int i = 0; i < todos.length; i++) {
      todos[i].id = ids[i];
    }
    return todos;
  }

  Future<List<TodoModel>> getTodoByDate(DateTime date) async {
    String todayFormat = DateFormat('yyyy-MM-dd').format(date);
    try {
      // List<Map> maps = await db.query(tableTodo, where: "created_at = ?", whereArgs: [dateDbFormat(date)]);
      List<Map> maps = await db.query(
        tableTodo,
        where: "date(created_at) = ?",
        whereArgs: [todayFormat],
        orderBy: "datetime(created_at) desc",
      );

      List<TodoModel> todos = maps.map<TodoModel>((todoMap) {
        return TodoModel.fromMap(todoMap);
      }).toList();
      return todos;
    } catch(error) {
      return [];
    }
  }

  Future<int> update(TodoModel todo) async {
    return await db.update(tableTodo, todo.toMap(),
      where: 'id = ?', whereArgs: [todo.id]);
  }
  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: 'id = ?', whereArgs: [id]);
  }
}