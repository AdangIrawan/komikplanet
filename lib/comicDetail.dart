import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void initState() {
    super.initState();
    // Dapatkan UID pengguna yang sedang masuk
    userId = FirebaseAuth.instance.currentUser?.uid;
    // Periksa apakah komik sudah di-bookmark saat halaman dimuat
    isBookmarked = Booklish.bookmarkedComics.contains(widget.comic);
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
                  // Periksa apakah pengguna sudah masuk dan dapatkan ID pengguna jika sudah
                  if (userId != null) {
                    if (isBookmarked) {
                      await Booklish.addBookmark(
                          userId!, widget.comic); // Tambahkan ke bookmark
                    } else {
                      await Booklish.removeBookmark(
                          userId!, widget.comic); // Hapus dari bookmark
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.blue, // Ganti warna sesuai kebutuhan
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
                return ListTile(
                  title: Text(widget.comic.chapters[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChapterDetailPage(
                          title: widget.comic.title,
                          chapter: widget.comic.chapters[index].title,
                          images: widget.comic.chapters[index].images,
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