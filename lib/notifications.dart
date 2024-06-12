// notifications.dart
import 'package:flutter/material.dart';

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
        title: Text('Notifications'),
        backgroundColor: Color.fromARGB(255, 17, 0, 58),
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
    );
  }
}
