import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/screens/Init.dart';
import 'package:ktodo/screens/ReadingBook/main.dart';
import 'package:ktodo/screens/Template.dart';
import 'package:ktodo/screens/Todo.dart';

class RouteNames {
  static final String template = 'template';
  static final String home = 'init';
  static final String todo = 'todo';
  static final String readingBook = 'readingBook';
}

final Map<String, Widget Function(BuildContext)> routes = {
  RouteNames.template: (context) => Template(),
  RouteNames.home: (context) => Init(),
  RouteNames.todo: (context) => Todo(),
  RouteNames.readingBook: (context) => ReadingBook()
};
