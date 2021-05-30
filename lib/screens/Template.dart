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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template'),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, index) {
        return Row(
          children: [
            Container(
              width: 30,
              child: Text('${index + 1}.', textAlign: TextAlign.right,),
              padding: EdgeInsets.only(right: 10)
            ),
            Expanded(child: Text('${index + 1} ${template.todoList[index]}'))
          ]);
      }, itemCount: template.todoList.length,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AddTemplateItemPopup()).then((value) {
            if(value != null) {
              setState(() {
                template.todoList.add(value);
              });
            }
          });
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}

