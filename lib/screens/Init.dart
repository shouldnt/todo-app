import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/Routes.dart';
import 'package:ktodo/shared/app.dart';
import 'package:ktodo/widgets/AddTemplateItemPopup.dart';

import 'Template.dart';

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

  Map<String, dynamic> getView(index) {
    switch(index) {
      case 0:
        return {
          "widget": new Template(),
          "title": 'Template'
        };
        break;
      default:
        return {
          "widget": Container(
            child: Text('empty')
          ),
          "title": "Empty"
        };
    }
  }
  @override
  Widget build(BuildContext context) {
    if(!initDone) {
      return Container(
        color: Colors.green
      );
    }
    Map<String, dynamic> view  = getView(currentIndex);
    return Scaffold(
      appBar: AppBar(
        title: Text(view["title"]),
      ),
      body: Container(
        child: view["widget"]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Todo',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Template',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

      ),
    );
  }
}