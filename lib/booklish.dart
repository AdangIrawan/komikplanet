import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Komik.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'comicDetail.dart';
import 'home.dart'; // Make sure to import the HomePage
import 'notifications.dart'; // Make sure to import the NotificationsPage
import 'profile.dart'; // Make sure to import the ProfilePage

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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 11, 1, 35), // color fix
        unselectedItemColor: Colors.grey, // Set color for unselected items
        selectedItemColor: Colors.white, // Set color for selected items
        type: BottomNavigationBarType.fixed, // Ensure the background is applied to all items
        currentIndex: 1, // Set the current index to highlight the Bookmark tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Already on BookmarkPage, no need to navigate
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          } else if (index == 3) {
            User user = FirebaseAuth.instance.currentUser!;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
            );
          }
        },
      ),
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
