import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/DB/reading_book_provider.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/models/reading_book.dart';
import 'package:ktodo/screens/ReadingBook/widget/AddBook.dart';
import 'package:ktodo/screens/ReadingBook/widget/Item.dart';
import 'package:ktodo/shared/widgets/Drawer.dart';
import 'package:provider/provider.dart';

class ReadingBook extends StatefulWidget {
  @override
  _ReadingBookState createState() => _ReadingBookState();
}

class _ReadingBookState extends State<ReadingBook> {
  List<ReadingBookModel> books = [];
  ReadingBookProvider provider = new ReadingBookProvider();

  init() async {
    getReadingBooks();
  }

  getReadingBooks() async {
    books = await provider.getReadingBooks();
    setState(() {

    });
  }

  deleteBook(index) {
    ReadingBookModel book;
    setState(() {
      book = books.removeAt(index);
    });
    provider.delete(book.id);
  }

  addBook(ReadingBookModel book) async {
    book = await provider.createReadingBook(book);
    setState(() {
      books.insert(0, book);
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ReadingBook'),
          ],
        ),
        actions: [
          Row(
            children: [
              Text('${books.length}'),
            ],
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                ReadingBookModel _book = await showDialog<ReadingBookModel>(
                    context: context,
                    builder: (context) {
                      return AddBook();
                    });
                if (_book != null) {
                  addBook(_book);
                }
              }),
        ],
      ),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                itemBuilder: (BuildContext context, index) {
                  ReadingBookModel book = books[index];
                  // todo update book item
                  return BookItem(book: book, onChange: (book) {
                    setState(() {
                      books[index] = book;
                    });
                  }, onDelete: () async {
                    await ReadingBookProvider().delete(book.id);
                    setState(() => {
                      this.books.removeAt(index)
                    });
                  });
                },
                itemCount: books.length,
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
