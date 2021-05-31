import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/models/todo.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(bool) onCheckBoxChange;
  final Function() onDeleteBtnPress;
  TodoItem(this.todo, {this.onCheckBoxChange, this.onDeleteBtnPress});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(
            (states) => Colors.green
          ),
          value: todo.completed,
          onChanged: onCheckBoxChange
        ),
        Expanded(child: Text(todo.description)),
        IconButton(icon: Icon(Icons.delete_forever, color: Colors.red,), onPressed: onDeleteBtnPress)
      ],
    );
  }

}