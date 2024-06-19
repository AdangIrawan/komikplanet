import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'home.dart';
import 'notifications.dart';
import 'booklish.dart';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? photoURL;
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _getUserData();
    if (snapshot.exists) {
      setState(() {
        photoURL = snapshot.data()?['photoURL'] ?? 'https://via.placeholder.com/150';
      });
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData() {
    return FirebaseFirestore.instance.collection('account').doc(widget.user.uid).get();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
        (route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> _changeProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      try {
        // Upload to Firebase Storage
        String fileName = 'profile_pictures/${widget.user.uid}.jpg';
        await FirebaseStorage.instance.ref(fileName).putFile(imageFile);

        // Get the download URL
        String downloadURL = await FirebaseStorage.instance.ref(fileName).getDownloadURL();

        // Update the user's photoURL in Firestore
        await FirebaseFirestore.instance.collection('account').doc(widget.user.uid).update({
          'photoURL': downloadURL,
        });

        // Update the user's profile in FirebaseAuth
        await widget.user.updatePhotoURL(downloadURL);

        setState(() {
          // Update the photoURL to display the new profile picture
          photoURL = downloadURL;
        });
      } catch (e) {
        print('Error updating profile picture: $e');
      }
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

        Map<String, dynamic> userData = snapshot.data!.data()!;
        String username = userData['username'];

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile', style: TextStyle(color: Colors.white)),
            backgroundColor: Color.fromARGB(255, 11, 1, 35),
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => _signOut(context),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(photoURL!),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: _changeProfilePicture,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    username,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    widget.user.email ?? 'No email',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'User ID: ${widget.user.uid}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _changeProfilePicture,
                    icon: Icon(Icons.camera_alt),
                    label: Text('Change Profile Picture'),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Color.fromARGB(255, 11, 1, 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 11, 1, 35),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: 3,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookmarkPage()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RankPage()),
                );
              }
            },
          ),
        );
      },
    );
  }
}
