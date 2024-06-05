import 'package:flutter/material.dart';
import 'home.dart';

class ComicDetailPage extends StatelessWidget {
  final Comic comic;

  const ComicDetailPage({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
        backgroundColor: Color.fromARGB(255, 17, 0, 58),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(comic.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              comic.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Genre: ${comic.genre}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Rating: ${comic.rating}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              comic.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Chapters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comic.chapters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comic.chapters[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChapterContentPage(
                          chapterTitle: comic.chapters[index],
                          imagePaths: comic.chapterImages[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterContentPage extends StatelessWidget {
  final String chapterTitle;
  final List<String> imagePaths;

  const ChapterContentPage({
    Key? key,
    required this.chapterTitle,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapterTitle),
      ),
      body: PageView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Image.asset(imagePaths[index], fit: BoxFit.cover);
        },
      ),
    );
  }
}

class Comic {
  final String title;
  final String genre;
  final double rating;
  final String description;
  final String imagePath;
  final List<String> chapters;
  final List<List<String>> chapterImages;

  Comic({
    required this.title,
    required this.genre,
    required this.rating,
    required this.description,
    required this.imagePath,
    required this.chapters,
    required this.chapterImages,
  });
}
