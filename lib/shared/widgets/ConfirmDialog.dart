import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ConfirmDialog extends StatelessWidget {
  final Widget child;
  ConfirmDialog({@required this.child});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning', style: TextStyle(color: Colors.red)),
      content: SingleChildScrollView(
        child: child,
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