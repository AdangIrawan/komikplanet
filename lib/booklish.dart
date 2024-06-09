import 'package:flutter/material.dart';
import 'Komik.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmark'),
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
      ),
      body: Center(
        child: Text(
          'Your bookmarked comics will appear here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
class Booklish {
  static List<Comic> bookmarkedComics = [];

  static void addBookmark(Comic comic) {
    if (!bookmarkedComics.contains(comic)) {
      bookmarkedComics.add(comic);
    }
  }

  static void removeBookmark(Comic comic) {
    bookmarkedComics.remove(comic);
  }
}
