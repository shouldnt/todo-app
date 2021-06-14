import 'package:flutter/material.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/Routes.dart';
import 'package:ktodo/icons/remix.dart';
import 'package:provider/provider.dart';

class MenuItem {
  IconData icon;
  String routeName;
  String title;
  MenuItem({this.icon, this.routeName, this.title});

  Widget toWidget(context, ThemeModel theme) {
    bool isActive = ModalRoute.of(context).settings.name == routeName;
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
      child: Ink(
        child: Container(
            color: isActive ? theme.primaryColor : Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Icon(icon),
                Container(width: 5),
                Text(title),
              ],
            )
        ),
      ),
    );
  }
}

List<MenuItem> _menuItems = [
  MenuItem(
      icon: RemixIcons.listCheck2, routeName: RouteNames.todo, title: 'Todo'),
  MenuItem(
      icon: RemixIcons.fileListLine,
      routeName: RouteNames.template,
      title: 'Templates'),
  MenuItem(
      icon: RemixIcons.bookmarkLine,
      routeName: RouteNames.readingBook,
      title: 'Reading book')
];
Drawer buildDrawer(BuildContext context) {
  ThemeModel theme = Provider.of<ThemeModel>(context);
  return Drawer(
    child: Column(
      children: [
        Expanded(child: ListView.builder(
            itemBuilder: (context, index) {
              return _menuItems[index].toWidget(context, theme);
            },
            itemCount: _menuItems.length))
      ],
    ),
  );
}
