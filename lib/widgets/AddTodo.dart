import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/DB/template_provider.dart';
import 'package:ktodo/models/template.dart';
import 'package:ktodo/models/todo.dart';

class AddTodo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddTodoState();
  }
}

class _AddTodoState extends  State<AddTodo> {
  String desc = '';
  TextEditingController controller = new TextEditingController();
  bool useTemplate = false;
  String errorMessage;

  TodoModel createTodo(String desc) {
    return new TodoModel(description: desc, completed: false);
  }
  Future<List<TodoModel>> createTodosWithTemplate() async {
    TemplateProvider templateProvider = new TemplateProvider();
    List<TemplateModel> templates = await templateProvider.getTemplates();
    if(templates.length == 0) {
      return [];
    }
    return templates.map<TodoModel>((template) => TodoModel(description: template.description)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Todo Description'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...(useTemplate ? [] : [TextField(
            autofocus: true,
            controller: controller,
            onChanged: (value) {
              setState(() {
                desc = value;
              });
            },
          )]),
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.green
                ),
                value: useTemplate,
                onChanged: (value) {
                  setState(() {
                    useTemplate = value;
                  });
                }
              ),
              Expanded(child: Text('Use Template')),
            ],
          ),
          ...(errorMessage == null ? [] : [Text(errorMessage, style: TextStyle(color: Colors.red),)])
        ],
      ),
      actions: <Widget>[
        SizedBox.fromSize(
          size: Size(
            30, 30
          ),
          child: InkWell(
            splashColor: Colors.blue, // splash color
            onTap: () {
              Navigator.pop(context);
            }, // button pressed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.cancel, color: Colors.red,), // icon
              ],
            ),
          ),
        ),
        Container(width: 20),
        SizedBox.fromSize(
          size: Size(
            30, 30
          ),
          child: InkWell(
            splashColor: Colors.blue, // splash color
            onTap: desc.length == 0 && !useTemplate ? null : () async {
              List<TodoModel> todos = [];
              if(useTemplate) {
                todos = await createTodosWithTemplate();
              } else {
                todos = [createTodo(desc)];
              }
              if(todos.length == 0) {
                setState(() {
                  errorMessage = 'You should create at least 1 template item!';
                  useTemplate = false;
                });
                Future.delayed(Duration(seconds: 3), () {
                  setState(() {
                    errorMessage = null;
                  });
                });
                return;
              }
              Navigator.pop<List<TodoModel>>(context, todos);
            }, // button pressed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check, color: Colors.green,), // icon
              ],
            ),
          ),
        ),
      ],
    );
  }
}
