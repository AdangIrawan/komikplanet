import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ChapterDetailPage extends StatelessWidget {
  final String title;
  final String chapter;
  final String pdfPath;

  const ChapterDetailPage({
    Key? key,
    required this.title,
    required this.chapter,
    required this.pdfPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$chapter - $title',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: PDF().cachedFromUrl(
        pdfPath,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
