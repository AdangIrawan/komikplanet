import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Komik.dart'; // Import the comic.dart file
import 'addComic.dart';
import 'addChapter.dart';
import 'login.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late Future<List<Comic>> _comicsFuture;
  List<Comic> _comics = []; // Tambahkan variabel untuk menyimpan list komik

  @override
  void initState() {
    super.initState();
    _comicsFuture = _fetchComics();
  }

  Future<List<Comic>> _fetchComics() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('List Komik').get();
    _comics = snapshot.docs
        .map((doc) => Comic.fromMap(doc.data()))
        .toList(); // Simpan list komik ke dalam variabel
    return _comics;
  }

  void _addComic(Comic comic) {
    setState(() {
      // Tambahkan komik baru ke daftar komik
      _comicsFuture.then((comics) {
        comics.add(comic);
      });
    });
  }

  void _addChapter(String comicId, Chapter chapter) {
    // Cari komik berdasarkan ID dan tambahkan chapter baru
    setState(() {
      _comicsFuture.then((comics) {
        final comic = comics.firstWhere((c) => c.id == comicId);
        comic.chapters.add(chapter);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons
                .exit_to_app), // Gunakan icon exit_to_app atau icon lain yang sesuai
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LoginPage(), // Ganti dengan halaman login yang sesuai
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome to the Admin Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddComicPage(onAddComic: _addComic),
                  ),
                );
              },
              child: Text('Add Comic'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddChapterPage(
                        comics: _comics, // Gunakan variabel _comics di sini
                        onAddChapter: _addChapter),
                  ),
                );
              },
              child: Text('Add Chapter'),
            ),
            FutureBuilder<List<Comic>>(
              future: _comicsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final comics = snapshot.data ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: comics.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(comics[index].title),
                        subtitle: Text(comics[index].genre),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
