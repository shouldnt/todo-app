import 'package:ktodo/shared/helpers.dart';

import '../constants.dart';

class TemplateModel {
  int id;
  String description;
  DateTime createdAt;
  Priorities priority;
  TemplateModel({this.id, this.description, this.priority}) {
    this.createdAt = DateTime.now();
  }
  toMap() {
    Map<String, dynamic> map = {
      "description": description,
      "created_at": createdAt.toIso8601String(),
      "priority": priorityEnumToNumber(priority)
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }
  TemplateModel.fromMap(map) {
    id = map["id"];
    description = map["description"];
    createdAt = DateTime.parse(map["created_at"]);
    priority = numberToPriorityEnum(map["priority"]);
  }
}
