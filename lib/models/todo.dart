import 'package:flutter/cupertino.dart';

class TodoModel {
  String desc;
  bool completed;
  String completedAt;
  TodoModel({@required this.desc, this.completed, this.completedAt});
}