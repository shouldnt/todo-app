class TemplateModel {
  int id;
  String description;
  DateTime createdAt;
  TemplateModel({this.id, this.description}) {
    this.createdAt = DateTime.now();
  }
  toMap() {
    Map<String, dynamic> map = {
      "description": description,
      "created_at": createdAt.toIso8601String()
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
  }
}
