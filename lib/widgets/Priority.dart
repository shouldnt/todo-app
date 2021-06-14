import 'package:flutter/cupertino.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../constants.dart';

class Priority extends StatelessWidget {
  final Priorities priority;
  final defaultColor = Color(0xff000000);
  Color colorsOf(Priorities priority, ThemeModel theme) {
    return priority == Priorities.low ? theme.lowPriorityColor : priority == Priorities.high ? theme.highPriorityColor : theme.mediumPriorityColor;
  }
  Priority(this.priority);
  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Transform.rotate(
      angle: -math.pi / 4,
      child: Container(
        width: 20,
        height: 20,
        color: colorsOf(priority, theme),
      ),
    );
  }

}