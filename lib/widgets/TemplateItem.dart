import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/models/template.dart';
import 'package:provider/provider.dart';

class TemplateItem extends StatelessWidget {
  final TemplateModel template;
  final Function() onDeleteBtnPress;

  TemplateItem(this.template, {this.onDeleteBtnPress});

  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 0,
          left: 15
        ),
        margin: EdgeInsets.only(bottom: 15),
        decoration: ShapeDecoration.fromBoxDecoration(
            BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: theme.primaryColor,
                boxShadow: [BoxShadow(
                  color: theme.shadowColor,
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(0, 4),
                )]
            )
        ),
        child: Row(
          children: [
            Expanded(child: Text(template.description)),
            IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: onDeleteBtnPress)
          ],
        )
    );
  }
}
