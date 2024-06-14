import 'package:flutter/material.dart';

class ChapterDetailPage extends StatelessWidget {
  final String title;
  final String chapter;
  final List<String> images;

  const ChapterDetailPage({
    Key? key,
    required this.title,
    required this.chapter,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title - $chapter'),
        backgroundColor: Color.fromARGB(255, 17, 0, 58),
      ),
      body: PageView.builder(
        itemCount: images.length, // Update with the actual number of images
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(images[index],
                fit: BoxFit.contain), // Use the actual image paths
          );
        },
      ),
    );
  }
}