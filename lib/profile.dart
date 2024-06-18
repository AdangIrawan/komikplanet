import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart'; // Import HomePage if not already imported
import 'rank.dart'; // Import NotificationsPage if not already imported
import 'bookmark.dart'; // Import BookmarkPage if not already imported
import 'main.dart'; // Import your main.dart file where you initialize Firebase

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData() {
    // Fetch user data from Firestore
    return FirebaseFirestore.instance.collection('account').doc(user.uid).get();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyApp()), // Replace MyApp with your initial app page
        (route) => false, // Prevent user from navigating back
      );
    } catch (e) {
      print('Error signing out: $e');
      // Handle error signing out
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('User not found'));
        }

        // Retrieve user data from snapshot
        Map<String, dynamic> userData = snapshot.data!.data()!;
        String username = userData['username'];

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile',style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color.fromARGB(255, 11, 1, 35),
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => _signOut(context), // Tambahkan tombol logout di sini
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.photoURL ?? 'https://via.placeholder.com/150'),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    username ?? 'No display name',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    user.email ?? 'No email',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'User ID: ${user.uid}',
                  style: TextStyle(fontSize: 16),
                ),
                // Add more fields as needed
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 11, 1, 35), // color fix
            unselectedItemColor: Colors.grey, // Set color for unselected items
            selectedItemColor: Colors.white, // Set color for selected items
            type: BottomNavigationBarType.fixed, // Ensure the background is applied to all items
            currentIndex: 3, // Set the current index to indicate ProfilePage
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
            onTap: (int index) {
              if (index == 0) {
                // If the Home icon is clicked, navigate to HomePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else if (index == 1) {
                // If the Bookmark icon is clicked, navigate to BookmarkPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookmarkPage()),
                );
              } else if (index == 2) {
                // If the Notifications icon is clicked, navigate to NotificationsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RankPage()),
                );
              }
              // Note: For index 3 (Profile), we stay on the ProfilePage
            },
          ),
        );
      },
    );
  }
}
