import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Komik.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'comicDetail.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dapatkan UID pengguna yang sedang masuk
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmark'),
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
      ),
      body: BookmarkedComicsList(userId: userId),
    );
  }
}

class BookmarkedComicsList extends StatelessWidget {
  final String? userId;

  const BookmarkedComicsList({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userId != null
          ? FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('Bookmark')
              .snapshots()
          : null,
      builder: (context, AsyncSnapshot<QuerySnapshot>? snapshot) {
        if (snapshot == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), // Tampilkan loading jika data belum tersedia
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // Ambil daftar bookmarked comics dari snapshot
          List<Comic> bookmarkedComics =
              snapshot.data!.docs.map((DocumentSnapshot doc) {
            return Comic.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          if (bookmarkedComics.isEmpty) {
            return Center(
              child: Text(
                'You have no bookmarked comics.',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: bookmarkedComics.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComicDetailPage(comic: bookmarkedComics[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.asset(bookmarkedComics[index].imagePath), // Tambahkan gambar sebagai leading
                    title: Text(bookmarkedComics[index].title),
                    subtitle: Text(bookmarkedComics[index].genre),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}

class Booklish {
  static List<Comic> bookmarkedComics = [];

  static Future<void> addBookmark(String userId, Comic comic) async {
    if (!bookmarkedComics.contains(comic)) {
      bookmarkedComics.add(comic);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Bookmark')
          .doc(comic.id)
          .set(comic.toMap());
    }
  }

  static Future<void> removeBookmark(String userId, Comic comic) async {
    bookmarkedComics.remove(comic);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Bookmark')
        .doc(comic.id)
        .delete(); // Menggunakan delete() untuk menghapus komik dari Firestore
  }

  // Method to check if a comic is bookmarked by a specific user
  static Future<bool> isComicBookmarked(String userId, Comic comic) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId) // Gunakan UID pengguna sebagai ID dokumen
        .collection('Bookmark')
        .doc(comic.id)
        .get();
    return snapshot.exists;
  }
   static Future<List<String>> getReadChapters(String userId, String comicId) async {
  List<String> readChapters = [];

  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('ReadChapters')
      .doc(comicId)
      .get();

  if (snapshot.exists) {
    readChapters = List<String>.from(snapshot.data()!['chapters'] as List<dynamic>);
  }

  return readChapters;
}


}