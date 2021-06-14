import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/Routes.dart';
import 'package:ktodo/icons/remix.dart';
import 'package:ktodo/shared/app.dart';
import 'package:ktodo/shared/widgets/Drawer.dart';
import 'package:ktodo/widgets/BottomNav.dart';
import 'package:provider/provider.dart';

import 'Template.dart';
import 'Todo.dart';

class Init extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InitState();
  }
}

class _InitState extends State<Init> {
  bool initDone = false;
  int currentIndex = 0;
  @override
  initState() {
    super.initState();
    app.init().then((value) {
      Navigator.pushReplacementNamed(context, RouteNames.todo);
    });
  }

  List<Map<String, dynamic>> views = [
    {
      "widget": new Todo(),
      "icon": RemixIcons.listCheck2,
      "title": "Todo"
    },
    {
      "widget": new Template(),
      "icon": RemixIcons.fileListLine,
      "title": "Template"
    }
  ];
  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    if(!initDone) {
      return Container(
        color: Colors.green
      );
    }
    Map<String, dynamic> view  = views[currentIndex];
    return SafeArea(child: Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(child: view["widget"]),
            BottomNav(icons: views.map<IconData>((e) => e["icon"]).toList(), onChange: (index) {
              setState(() {
                this.currentIndex = index;
              });
            },),
          ],
        )
      ),
    ));
  }
}