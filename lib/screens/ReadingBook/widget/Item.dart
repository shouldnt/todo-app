import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/icons/remix.dart';
import 'package:ktodo/models/reading_book.dart';
import 'package:ktodo/screens/ReadingBook/widget/EditBook.dart';
import 'package:ktodo/shared/widgets/ConfirmDialog.dart';
import 'package:provider/provider.dart';

class BookItem extends StatelessWidget {
  final ReadingBookModel book;
  final Function(ReadingBookModel) onChange;
  final Function onDelete;
  BookItem({@required this.book, @required this.onChange, this.onDelete});

  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: ShapeDecoration.fromBoxDecoration(BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: theme.primaryColor,
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor,
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(0, 4),
              )
            ])),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              IconButton(
                icon: Icon(RemixIcons.edit2Line, color: Colors.greenAccent),
                onPressed: () => {
                  showDialog(
                      context: context,
                      builder: (context) => EditBook(book)).then((book) {
                        onChange(book);
                  })
                },
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Container(height: 5),
                  Text('Bookmark: ${book.markPage ?? 0}'),
                  Text('Read times: ${book.readCount ?? 0}'),
                ],
              )),
              IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                            context: context,
                            builder: (context) =>
                                ConfirmDialog(child: Text('delete this book')))
                        .then((value) {
                      value && onDelete();
                    });
                  }),
            ],
          ),
        ));
  }
}
