import 'package:flutter/cupertino.dart';
import 'package:ktodo/shared/helpers.dart';

import '../constants.dart';

class TodoModel {
  int id;
  String description;
  bool completed;
  DateTime createdAt;
  Priorities priority;
  TodoModel({@required this.description, this.completed = false, this.id, this.createdAt, this.priority = Priorities.medium}) {
    this.createdAt = this.createdAt ?? DateTime.now();
  }
  TodoModel.fromMap(map) {
    description = map["description"];
    completed = map["completed"] == 0 ? false : true;
    id = map["id"];
    createdAt = DateTime.parse(map["created_at"]);
    priority = numberToPriorityEnum(map["priority"]);
  }
  toMap() {
    Map<String, dynamic> map = {
      "description": description,
      "completed": this.completed ? 1 : 0,
      "created_at": this.createdAt.toIso8601String(),
      "priority": priorityEnumToNumber(this.priority)
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }
}