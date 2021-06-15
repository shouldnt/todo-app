import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/models/reading_book.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  String bookName = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Name of the book'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            autofocus: true,
            onChanged: (value) {
              setState(() {
                bookName = value;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        SizedBox.fromSize(
          size: Size(30, 30),
          child: InkWell(
            splashColor: Colors.blue, // splash color
            onTap: () {
              Navigator.pop(context);
            }, // button pressed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ), // icon
              ],
            ),
          ),
        ),
        Container(width: 20),
        SizedBox.fromSize(
          size: Size(30, 30),
          child: InkWell(
            splashColor: Colors.blue, // splash color
            onTap: bookName.length == 0
                ? null
                : () async {
                    ReadingBookModel book =
                        new ReadingBookModel(name: bookName, readCount: 0, markPage: 0);
                    Navigator.pop<ReadingBookModel>(context, book);
                    return;
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check,
                  color: Colors.green,
                ), // icon
              ],
            ),
          ),
        ),
      ],
    );
  }
}
