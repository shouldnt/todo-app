import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/models/template.dart';
import 'package:ktodo/widgets/AddTemplateItemPopup.dart';

class Template extends StatefulWidget {

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {

  TemplateModel template = new TemplateModel(todoList: []);

  @override
  Widget build(BuildContext context) {
    if(template.todoList.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.priority_high, color: Colors.grey, size: 80,),
          Text('No Todo for today', textAlign: TextAlign.center,)
        ]
      );
    }
    return ListView.builder(itemBuilder: (BuildContext context, index) {
      return Row(
        children: [
          Container(
            width: 30,
            child: Text('${index + 1}.', textAlign: TextAlign.right,),
            padding: EdgeInsets.only(right: 10)
          ),
          Expanded(child: Text('${template.todoList[index]}'))
        ]);
    }, itemCount: template.todoList.length,);
  }
}

