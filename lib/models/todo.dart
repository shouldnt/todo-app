import 'package:flutter/cupertino.dart';

class TodoModel {
  int id;
  String description;
  bool completed;
  String createdAt;
  TodoModel({@required this.description, this.completed, this.id, this.createdAt});
  static TodoModel fromMap(map) {
    return new TodoModel(
      description: map["description"],
      completed: map["completed"] == 0 ? false : true,
      id: map["id"],
      createdAt: map["created_at"]
    );
  }
  toMap() {
    Map<String, dynamic> map = {
      "description": description,
      "completed": this.completed ? 1 : 0,
      "created_at": this.createdAt,
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }
}