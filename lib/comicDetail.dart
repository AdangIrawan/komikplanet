import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komikplanet/chapterDetail.dart';
import 'Komik.dart';
import 'booklish.dart';

class ComicDetailPage extends StatefulWidget {
  final Comic comic;

  const ComicDetailPage({Key? key, required this.comic}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
  String selectedTab = 'Description';
  bool isBookmarked = false;
  String? userId;
  List<String> readChapters = [];

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
    // Memeriksa apakah komik sudah di-bookmark oleh pengguna
    checkIsBookmarked();
    // Mengambil daftar chapter yang sudah dibaca oleh pengguna
    _fetchReadChapters();
  }

  Future<void> checkIsBookmarked() async {
    if (userId != null) {
      bool bookmarked = await Booklish.isComicBookmarked(userId!, widget.comic);
      setState(() {
        isBookmarked = bookmarked;
      });
    }
  }

  Future<void> _fetchReadChapters() async {
    if (userId != null && widget.comic.id.isNotEmpty) {
      List<String> chapters = await Booklish.getReadChapters(userId!, widget.comic.id);
      setState(() {
        readChapters = chapters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.comic.title),
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
                  image: AssetImage(widget.comic.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.comic.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Genre: ${widget.comic.genre}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Rating: ${widget.comic.rating}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                  // Menambah atau menghapus komik dari daftar bookmark di Firestore
                  if (userId != null) {
                    if (isBookmarked) {
                      await Booklish.addBookmark(userId!, widget.comic);
                    } else {
                      await Booklish.removeBookmark(userId!, widget.comic);
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Colors.blue : Colors.grey, // Ubah warna ikon sesuai status bookmark
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Bookmark',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Description';
                    });
                  },
                  child: Text('Description'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Synopsis';
                    });
                  },
                  child: Text('Synopsis'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Status Manga';
                    });
                  },
                  child: Text('Status Manga'),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (selectedTab == 'Description')
              Text(
                widget.comic.description,
                style: TextStyle(fontSize: 16),
              ),
            if (selectedTab == 'Synopsis')
              Text(
                widget.comic.synopsis,
                style: TextStyle(fontSize: 16),
              ),
            if (selectedTab == 'Status Manga')
              Text(
                widget.comic.status,
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
              itemCount: widget.comic.chapters.length,
              itemBuilder: (context, index) {
                bool isRead = readChapters.contains(widget.comic.chapters[index].title);
                return ListTile(
                  title: Text(
                    widget.comic.chapters[index].title,
                    style: TextStyle(color: isRead ? Colors.blue : Colors.black),
                  ),
                  onTap: () async {
                    if (!isRead) {
                      readChapters.add(widget.comic.chapters[index].title);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .collection('ReadChapters')
                          .doc(widget.comic.id)
                          .set({'chapters': readChapters});
                      setState(() {});
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChapterDetailPage(
                          title: widget.comic.title,
                          chapter: widget.comic.chapters[index].title,
                          pdfPath: widget.comic.chapters[index].pdfPath,
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
