import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'home.dart'; // Import HomePage if not already imported
import 'profile.dart'; // Import ProfilePage if not already imported
import 'booklish.dart'; // Import BookmarkPage if not already imported

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {'title': 'Spy x Family', 'message': 'New chapter available!'},
      {'title': 'Boku no Hero Academia', 'message': 'Chapter 312 is out now!'},
      {'title': 'Tensei Kizoku no Isekai Boukenroku', 'message': 'New chapter released!'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: TextStyle(color: Colors.white), // Change text color here),
        ),
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
        iconTheme: IconThemeData(color: Colors.white), // Change icon (back button) color here
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications),
            title: Text(notifications[index]['title']!),
            subtitle: Text(notifications[index]['message']!),
            onTap: () {
              // Handle notification tap, if needed
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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
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
}
