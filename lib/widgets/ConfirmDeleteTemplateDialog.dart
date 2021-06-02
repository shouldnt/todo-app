import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/models/template.dart';

class ConfirmDeleteTemplate extends StatelessWidget {
  final TemplateModel template;
  ConfirmDeleteTemplate(this.template);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning', style: TextStyle(color: Colors.red)),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Do you want delete template'),
            Text(template.description),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('cancel', style: TextStyle(
            color: Colors.red
          ) ,),
          onPressed: () {
            Navigator.pop<bool>(context, false);
          },
        ),
        TextButton(
          child: Text('confirm'),
          onPressed: () {
            Navigator.pop<bool>(context, true);
          },
        ),
      ],
    );
  }

}