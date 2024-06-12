import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    );
  }
}
