import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/models/template.dart';

class TemplateItem extends StatelessWidget {
  final TemplateModel template;
  final Function onDeleteBtnPress;
  TemplateItem(this.template, {this.onDeleteBtnPress});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(template.description),
        ),
        IconButton(icon: Icon(Icons.delete_forever, color: Colors.red,), onPressed: onDeleteBtnPress)
      ],
    );
  }

}