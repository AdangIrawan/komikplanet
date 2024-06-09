import 'package:flutter/material.dart';

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
