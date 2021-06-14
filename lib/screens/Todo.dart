import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ktodo/DB/todo_provider.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/icons/remix.dart';
import 'package:ktodo/models/todo.dart';
import 'package:ktodo/shared/widgets/Drawer.dart';
import 'package:ktodo/widgets/AddTodo.dart';
import 'package:ktodo/widgets/ConfirmDeleteTodoDialog.dart';
import 'package:ktodo/widgets/TodoItem.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<TodoModel> todos = [];
  TodoProvider provider = new TodoProvider();
  int completed = 0;
  bool showCalendar = false;
  DateTime selectedDate = DateTime.now();

  init() async {
    getTodos(selectedDate);
  }

  toggleCalendar() {
    setState(() {
      showCalendar = !showCalendar;
    });
  }

  getTodos(DateTime date) async {
    todos = await provider.getTodoByDate(date);
    setState(() {
      selectedDate = date;
    });
  }

  countCompleted() {
    int total = 0;
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].completed) {
        total++;
      }
    }
    this.completed = total;
  }

  setCompleted(TodoModel todo, bool value) async {
    setState(() {
      todo.completed = value;
      countCompleted();
    });
    await provider.update(todo);
  }

  deleteTodo(index) {
    TodoModel todo;
    setState(() {
      todo = todos.removeAt(index);
      countCompleted();
    });
    provider.delete(todo.id);
  }

  addTodos(List<TodoModel> todos) async {
    todos = await provider.createTodos(todos);
    todos.addAll(this.todos);
    setState(() {
      this.todos = todos;
      countCompleted();
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(RemixIcons.menuLine, color: theme.textColor),
        //   onPressed: () {
        //     theme.apply(set2);
        //   },
        // ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Todo'),
            Container(
              child: InkWell(
                splashColor: theme.primaryColor,
                onTap: () {
                  toggleCalendar();
                },
                child: Text('${DateFormat('dd/MM/yyyy').format(selectedDate)}'),
              ),
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Text('$completed'),
              Text('/${todos.length}'),
            ],
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                List<TodoModel> _todos = await showDialog<List<TodoModel>>(
                    context: context,
                    builder: (context) {
                      return AddTodo(selectedDate);
                    });
                if (_todos != null && _todos.length > 0) {
                  addTodos(_todos);
                }
              }),
        ],
      ),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                itemBuilder: (BuildContext context, index) {
                  TodoModel todo = todos[index];
                  return TodoItem(
                    todo,
                    onCheckBoxChange: (value) {
                      setCompleted(todo, value);
                    },
                    onDeleteBtnPress: () async {
                      if (await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return ConfirmDeleteTodo(todo);
                          })) {
                        deleteTodo(index);
                      }
                    },
                  );
                },
                itemCount: todos.length,
              )),
          ...(!showCalendar
              ? []
              : [
                  Builder(builder: (BuildContext context) {
                    DateTime _date = selectedDate;
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Positioned.fill(
                          child: Container(
                              color: theme.backgroundColor,
                              constraints: BoxConstraints.expand(),
                              child: Column(
                                children: [
                                  TableCalendar(
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: DateTime.now(),
                                    selectedDayPredicate: (day) {
                                      return isSameDay(_date, day);
                                    },
                                    onDaySelected: (selectedDate, focusDate) {
                                      setState(() {
                                        _date = selectedDate;
                                      });
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Ink(
                                        decoration: ShapeDecoration(
                                          color: theme.primaryColor,
                                          shape: CircleBorder(),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                              RemixIcons.closeCircleFill,
                                              color: Colors.red),
                                          color: Colors.white,
                                          onPressed: () {
                                            toggleCalendar();
                                          },
                                        ),
                                      ),
                                      Ink(
                                        decoration: ShapeDecoration(
                                          color: theme.primaryColor,
                                          shape: CircleBorder(),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(RemixIcons.checkLine,
                                              color: Colors.green),
                                          color: Colors.white,
                                          onPressed: () {
                                            getTodos(_date);
                                            toggleCalendar();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )));
                    });
                  })
                ]),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
