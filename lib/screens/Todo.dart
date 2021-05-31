import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/DB/todo_provider.dart';
import 'package:ktodo/models/template.dart';
import 'package:ktodo/models/todo.dart';
import 'package:ktodo/widgets/AddTemplateItemPopup.dart';
import 'package:ktodo/widgets/AddTodo.dart';
import 'package:ktodo/widgets/TodoItem.dart';

class Todo extends StatefulWidget {

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<TodoModel> todos = [];
  TodoProvider provider = new TodoProvider();

  init() async {
    await provider.open();
    todos = await provider.getTodoByDate(DateTime.now());
    setState(() { });
  }
  setCompleted(TodoModel todo, bool value) async {
    setState(() {
      todo.completed = value;
    });
    int result = await provider.update(todo);
    log(result.toString());
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
            TodoModel todo = await showDialog<TodoModel>(context: context, builder: (context) {
              return AddTodo();
            });
            if(todo == null) {
              return;
            }
            todo = await provider.create(todo);
            setState(() {
              todos.add(todo);
            });
          }
          )
        ],
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, index) {
        return TodoItem(
          todos[index],
          onCheckBoxChange: (value) {
            setCompleted(todos[index], value);
          },
          onDeleteBtnPress: () {
            deleteTodo(index);
          },
        );
      }, itemCount: todos.length,),
    );
  }

  @override
  void dispose() {
    provider.close();
    super.dispose();
  }
}

