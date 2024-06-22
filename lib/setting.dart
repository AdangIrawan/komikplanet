import 'package:flutter/material.dart';
import 'home.dart'; // Import HomePage if not already imported
import 'notifications.dart'; // Import NotificationsPage if not already imported
import 'booklish.dart'; // Import BookmarkPage if not already imported
import 'tutorial_page.dart'; // Ensure the path is correct

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutorial',
          style: TextStyle(color: Colors.white), // Change text color here
        ),
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
          color: Colors.white, // Set the background color to black
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(
                  255, 0, 0, 0), // Set button color to match background
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TutorialPage()),
              );
            },
            icon: Icon(Icons.menu_book,
                size: 40, color: Colors.white), // Increase icon size
            label: Text(
              'Tutorial Membaca',
              style: TextStyle(
                  fontSize: 24, color: Colors.white), // Increase text size
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 11, 1, 35), // color fix
        unselectedItemColor: Colors.grey, // Set color for unselected items
        selectedItemColor: Colors.white, // Set color for selected items
        type: BottomNavigationBarType
            .fixed, // Ensure the background is applied to all items
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
  }
}
