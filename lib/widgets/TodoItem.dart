import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/models/todo.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(bool) onCheckBoxChange;
  final Function() onDeleteBtnPress;

  TodoItem(this.todo, {this.onCheckBoxChange, this.onDeleteBtnPress});

  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: ShapeDecoration.fromBoxDecoration(
        BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: theme.primaryColor,
          boxShadow: [BoxShadow(
            color: theme.shadowColor,
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 4),
          )]
        )
      ),
        child: Row(
      children: [
        Checkbox(
            checkColor: Colors.white,
            fillColor:
                MaterialStateProperty.resolveWith((states) => Colors.green),
            value: todo.completed,
            onChanged: onCheckBoxChange),
        Expanded(child: Text(todo.description)),
        ...(todo.completed
            ? []
            : [
                IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    onPressed: onDeleteBtnPress)
              ])
      ],
    ));
  }
}
