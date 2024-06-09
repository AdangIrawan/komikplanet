import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Define the Comic class
class Comic {
  final String id;
  final String title;
  final String genre;

  Comic({required this.id, required this.title, required this.genre});

  // Optionally, a factory constructor to create a Comic from Firestore data
  factory Comic.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Comic(
      id: doc.id,
      title: data['title'] ?? '',
      genre: data['genre'] ?? '',
    );
  }
}

// Function to save bookmark for the current user
Future<void> saveBookmark(Comic comic) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if user is authenticated
    if (user != null) {
      // Get the user's UID
      String uid = user.uid;

      // Reference to the 'bookmarks' collection
      CollectionReference bookmarksCollection = FirebaseFirestore.instance.collection('Bookmark');

      // Add the bookmark to Firestore
      await bookmarksCollection.doc(comic.id).set({
        'uid': uid,  // Store the user's UID in the document
        'title': comic.title,
        'genre': comic.genre,
      });

      print('Bookmark added successfully for user: $uid');
    } else {
      print('User is not authenticated.');
    }
  } catch (e) {
    print('Error saving bookmark: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Create a sample comic
            Comic comic = Comic(id: 'comicId', title: 'Comic Title', genre: 'Action');
            // Save bookmark for the current user
            await saveBookmark(comic);
          },
          child: Text('Save Bookmark'),
        ),
      ),
    );
  }
}