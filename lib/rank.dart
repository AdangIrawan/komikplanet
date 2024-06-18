import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'home.dart'; // Import HomePage if not already imported
import 'profile.dart'; // Import ProfilePage if not already imported
import 'bookmark.dart'; // Import BookmarkPage if not already imported

class RankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ranking',
          style: TextStyle(color: Colors.white), // Change text color here
        ),
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
        iconTheme: IconThemeData(color: Colors.white), // Change icon (back button) color here
      ),
      body: FutureBuilder(
        future: getTopComics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No comics found.'));
          }

          List<Map<String, dynamic>> comics = snapshot.data as List<Map<String, dynamic>>;

          return ListView.builder(
            itemCount: comics.length,
            itemBuilder: (context, index) {
              final comic = comics[index];
              final title = comic['title'] ?? 'Unknown Title';
              final rating = comic['rating']?.toString() ?? 'No Rating';
              final imagePath = comic['imagePath'] ?? 'https://via.placeholder.com/150';

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: imagePath.startsWith('http') 
                        ? NetworkImage(imagePath)
                        : AssetImage(imagePath) as ImageProvider,
                  ),
                  title: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Rating: $rating'),
                  trailing: Text(
                    '#${index + 1}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Handle comic tap, if needed
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 11, 1, 35), // color fix
        unselectedItemColor: Colors.grey, // Set color for unselected items
        selectedItemColor: Colors.white, // Set color for selected items
        type: BottomNavigationBarType.fixed, // Ensure the background is applied to all items
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
            icon: Icon(Icons.emoji_events),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2, // Set currentIndex to 2 to highlight Notifications
        onTap: (int index) {
          // Handle tab selection
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarkPage()),
              );
              break;
            case 2:
              // Already on Notifications page
              break;
            case 3:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
                );
              }
              break;
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getTopComics() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('List Komik') // Reference to the 'List Komik' collection
        .orderBy('rating', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
