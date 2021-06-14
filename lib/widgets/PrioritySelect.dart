import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class PrioritySelect extends StatelessWidget {
  final Priorities priority;
  final Function(Priorities) onChange;
  PrioritySelect({@required this.priority,@required this.onChange});
  colorBox(Priorities priority,Color color, bool isActive,Function(Priorities) onChange) {
    return GestureDetector(
      onTap: isActive ? null : () {
        onChange(priority);
      },
      child: Column(
        children: [
          Container(
            color: color,
            width: 20,
            height: 20,
          ),
          Container(height: 2),
          Container(
            color: !isActive ? Color.fromARGB(0, 0, 0, 0) : Color.fromARGB(150, 255, 255, 255),
            width: 20,
            height: 2,
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Row(
      children: [
        colorBox(Priorities.low, theme.lowPriorityColor, priority == Priorities.low , onChange),
        Container(width: 10),
        colorBox(Priorities.medium, theme.mediumPriorityColor, priority == Priorities.medium , onChange),
        Container(width: 10),
        colorBox(Priorities.high, theme.highPriorityColor, priority == Priorities.high , onChange),
      ],
    );
  }

}