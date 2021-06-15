import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/DB/reading_book_provider.dart';
import 'package:ktodo/models/reading_book.dart';
import 'package:ktodo/models/todo.dart';
import 'package:ktodo/shared/helpers.dart';

class EditBook extends StatefulWidget {
  final ReadingBookModel book;
  EditBook(this.book);
  @override
  State<StatefulWidget> createState() {
    return _EditBookState();
  }
}

class _EditBookState extends State<EditBook> {
  ReadingBookModel book;

  TextEditingController nameController = new TextEditingController();
  TextEditingController bookmarkController = new TextEditingController();
  TextEditingController readTimesController = new TextEditingController();
  @override
  void initState() {
    setState(() {
      book = widget.book.clone();
      nameController.text = book.name ?? '';
      bookmarkController.text = book.markPage != null ? '${book.markPage}' : '0';
      readTimesController.text = book.readCount != null ? '${book.readCount}' : '0';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: () async {
        Navigator.pop<ReadingBookModel>(context, widget.book);
        return false;
      },
      child: AlertDialog(
        title: const Text('Todo Description'),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Tên:"),
            TextField(
              autofocus: true,
              controller: nameController,
              onChanged: (value) {
                setState(() {
                  book.name = value;
                });
              },
            ),
            Container(height: 3),
            Row(
              children: [
                Container(child: Text("Bookmark:"), width: 130),
                Expanded(child: TextField(
                  textAlign: TextAlign.right,
                  autofocus: true,
                  inputFormatters: [inputNumberOnlyFormatter()],
                  controller: bookmarkController,
                  onChanged: (value) {
                    setState(() {
                      book.markPage = int.parse(value != '' ? value : '0');
                    });
                  },
                ))
              ],
            ),
            Container(height: 3),
            Row(
              children: [
                Container(child: Text("Read Times:"), width: 130),
                Expanded(child: TextField(
                  textAlign: TextAlign.right,
                  autofocus: true,
                  inputFormatters: [inputNumberOnlyFormatter()],
                  controller: readTimesController,
                  onChanged: (value) {
                    setState(() {
                      book.readCount = int.parse(value != '' ? value : '0');
                    });
                  },
                ))
              ],
            ),
            Container(height: 3),
          ],
        ),
        actions: <Widget>[
          SizedBox.fromSize(
            size: Size(30, 30),
            child: InkWell(
              splashColor: Colors.blue, // splash color
              onTap: () {
                Navigator.pop<ReadingBookModel>(context, widget.book);
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
              onTap: book.name.length == 0
                  ? null
                  : () async {
                try {
                  await ReadingBookProvider().update(book);
                  Navigator.pop<ReadingBookModel>(context, book);
                } catch (error) {
                  Navigator.pop<ReadingBookModel>(context, widget.book);
                }
              }, // button pressed
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
      )
    );
  }
}
