import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/screens/Init.dart';
import 'package:ktodo/screens/Template.dart';

class RouteNames {
  static final String template = 'template';
  static final String home = 'init';
  static final String todo = 'todo';
}

final Map<String, Widget Function(BuildContext)> routes = {
  RouteNames.template: (context) => Template(),
  RouteNames.home: (context) => Init(),
  RouteNames.todo: (context) => Container(color: Colors.green,),
};
