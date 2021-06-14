import 'package:flutter/cupertino.dart';

class ReadingBookModel {
  int id;
  String name;
  DateTime createdAt;
  int markPage;
  int readCount;
  ReadingBookModel({@required this.name, this.createdAt, this.id, this.readCount}) {
    this.createdAt = this.createdAt ?? DateTime.now();
  }
  ReadingBookModel.fromMap(map) {
    id = map["id"];
    name = map["name"];
    createdAt = DateTime.parse(map["created_at"]);
    markPage = map["mark_page"];
    readCount = map["read_count"];
  }
  toMap() {
    Map<String, dynamic> map = {
      "name": name,
      "created_at": this.createdAt.toIso8601String(),
      "mark_page": this.markPage,
      "read_count": this.readCount,
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }
}