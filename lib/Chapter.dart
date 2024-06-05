import 'package:flutter/material.dart';
import 'DetailKomik.dart';

class ChapterContentPage extends StatelessWidget {
  final String chapterTitle;

  const ChapterContentPage({required this.chapterTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapterTitle),
      ),
      body: Center(
        child: Text(
          chapterTitle,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

