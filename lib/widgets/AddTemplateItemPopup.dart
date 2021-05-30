import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTemplateItemPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddTemplateItemPopupState();
  }
}

class _AddTemplateItemPopupState extends  State<AddTemplateItemPopup> {
  String desc = '';
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Todo Description'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: controller,
            onChanged: (value) {
              setState(() {
                desc = value;
              });
            },
          )
        ],
      ),
      actions: <Widget>[
        SizedBox.fromSize(
          size: Size(
            30, 30
          ),
          child: InkWell(
            splashColor: Colors.blue, // splash color
            onTap: () {
              Navigator.pop(context);
            }, // button pressed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.cancel, color: Colors.red,), // icon
              ],
            ),
          ),
        ),
        Container(width: 20),
        SizedBox.fromSize(
          size: Size(
            30, 30
          ),
          child: InkWell(
            splashColor: Colors.blue, // splash color
            onTap: desc.length == 0 ? null : () {
              Navigator.pop(context, desc);
            }, // button pressed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check, color: Colors.green,), // icon
              ],
            ),
          ),
        ),
      ],
    );
  }
}
