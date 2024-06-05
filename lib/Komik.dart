import 'package:flutter/material.dart';
import 'DetailKomik.dart';

class KomikPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Comic> comics = [
      Comic(
        title: 'Comic 1',
        genre: 'Action',
        rating: 4.5,
        description: 'This is a description of Comic 1.',
        imagePath: 'assets/comics/comic1/cover.jpg',
        chapters: ['Chapter 1', 'Chapter 2', 'Chapter 3'],
        chapterImages: [
          [
            'assets/comics/comic1/page1.jpg',
            'assets/comics/comic1/page2.jpg',
            'assets/comics/comic1/page3.jpg',
          ],
          // Add more chapter images here
        ],
      ),
      // Add more comics here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Komik'),
        backgroundColor: Color.fromARGB(255, 17, 0, 58),
      ),
      body: ListView.builder(
        itemCount: comics.length,
        itemBuilder: (context, index) {
          return ComicCard(comic: comics[index]);
        },
      ),
    );
  }
}

class ComicCard extends StatelessWidget {
  final Comic comic;

  const ComicCard({required this.comic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComicDetailPage(comic: comic),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(comic.imagePath), // Use the cover image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                comic.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(comic.genre),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Rating: ${comic.rating}'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KomikPage(),
  ));
}
