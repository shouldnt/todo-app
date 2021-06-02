import 'package:flutter/cupertino.dart';

class TodoModel {
  int id;
  String description;
  bool completed;
  DateTime createdAt;
  TodoModel({@required this.description, this.completed = false, this.id}) {
    this.createdAt = DateTime.now();
  }
  TodoModel.fromMap(map) {
    description = map["description"];
    completed = map["completed"] == 0 ? false : true;
    id = map["id"];
    createdAt = DateTime.parse(map["created_at"]);
  }
  toMap() {
    Map<String, dynamic> map = {
      "description": description,
      "completed": this.completed ? 1 : 0,
      "created_at": this.createdAt.toIso8601String(),
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }
}