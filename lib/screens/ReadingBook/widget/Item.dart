import 'package:flutter/cupertino.dart';
import 'package:ktodo/models/reading_book.dart';

class BookItem extends StatefulWidget {
  final ReadingBookModel book;
  BookItem(this.book);
  @override
  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    // todo book item
    return Container(
      child: Text('${widget.book.name}'),
    );
  }

}