import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/icons/remix.dart';
import 'package:ktodo/shared/app.dart';
import 'package:ktodo/widgets/BottomNav.dart';

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
    app.init().then((value) {
      setState(() {
        initDone = true;
      });
    });
    super.initState();
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
    if(!initDone) {
      return Container(
        color: Colors.green
      );
    }
    Map<String, dynamic> view  = views[currentIndex];
    return SafeArea(child: Scaffold(
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