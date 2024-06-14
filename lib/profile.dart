import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart'; // Import HomePage if not already imported
import 'notifications.dart'; // Import NotificationsPage if not already imported
import 'booklish.dart'; // Import BookmarkPage if not already imported

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(255, 130, 112, 173),
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
                user.displayName ?? 'No display name',
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
        backgroundColor: Color.fromARGB(255, 130, 112, 173), // color fix
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
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          } else if (index == 3) {
            // If the Profile icon is clicked, stay on the ProfilePage
          }
        },
      ),
    );
  }
}
