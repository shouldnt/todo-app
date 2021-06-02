import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/DB/todo_provider.dart';
import 'package:ktodo/models/template.dart';
import 'package:ktodo/models/todo.dart';
import 'package:ktodo/widgets/AddTodo.dart';
import 'package:ktodo/widgets/ConfirmDeleteTodoDialog.dart';
import 'package:ktodo/widgets/TodoItem.dart';

class Todo extends StatefulWidget {

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<TodoModel> todos = [];
  TodoProvider provider = new TodoProvider();

  init() async {
    todos = await provider.getTodoByDate(DateTime.now());
    setState(() { });
  }
  setCompleted(TodoModel todo, bool value) async {
    setState(() {
      todo.completed = value;
    });
    int result = await provider.update(todo);
  }
  deleteTodo(index) {
    TodoModel todo;
    setState(() {
      todo = todos.removeAt(index);
    });
    provider.delete(todo.id);
  }
  @override
  void initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
            List<TodoModel> _todos = await showDialog<List<TodoModel>>(context: context, builder: (context) {
              return AddTodo();
            });
            if(_todos == null || _todos.length == 0) {
              return;
            }
            _todos = await provider.createTodos(_todos);
            _todos.addAll(todos);
            setState(() {
              todos = _todos;
            });
          }
          )
        ],
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, index) {
        TodoModel todo = todos[index];
        return TodoItem(
          todo,
          onCheckBoxChange: (value) {
            setCompleted(todo, value);
          },
          onDeleteBtnPress: () async {
            if(await showDialog<bool>(context: context, builder: (context) {
              return ConfirmDeleteTodo(todo);
            })) {
              deleteTodo(index);
            }
          },
        );
      }, itemCount: todos.length,),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

