import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class ChapterDetailPage extends StatelessWidget {
  final String title;
  final String chapter;
  final Future<String> pdfPath;

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
        title: Text('$title - $chapter'),
        backgroundColor: Color.fromARGB(255, 17, 0, 58),
      ),
      body: FutureBuilder<String>(
        future: pdfPath,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data!,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<String> getFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final file = File('$path/namaFilePDF.pdf'); // Ganti dengan nama file PDF Anda
  return file.path;
}