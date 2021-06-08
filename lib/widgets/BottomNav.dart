import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/widgets/MenuIndicator.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  final List<IconData> icons;
  final Function(int) onChange;
  final int defaultIndex;
  const BottomNav({this.icons, this.onChange, this.defaultIndex = 0});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int activeIndex;
  @override
  void initState() {
    activeIndex = widget.defaultIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int iconIndex = 0;
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.primaryColor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: widget.icons.map<Widget>((iconData) {
              int index = iconIndex;
              bool isActive = index == activeIndex;
              Color color = isActive ? theme.accentColor : theme.textColor;
              iconIndex++;
              return Expanded(
                  child: GestureDetector(
                      onTap: () {
                        if(isActive) return;
                        setState(() {
                          activeIndex = index;
                        });
                        widget.onChange(index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: isActive ? 20 : 15,
                          left: 15,
                          bottom: isActive ? 10 : 15,
                          right: 15,
                        ),
                        child: Icon(iconData, color: color),
                      )
                  )
              );
            }).toList(),
          ),
          Positioned(
            top: -5,
            left: 0,
            right: 0,
            child: MenuIndicator(activeIndex, widget.icons.length)
          )
        ],
      )
    );
  }
}