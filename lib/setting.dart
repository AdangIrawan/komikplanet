import 'package:flutter/material.dart';
import 'home.dart';
import 'package:komikplanet/settings/accountSettings.dart';
import 'package:komikplanet/settings/nontification.dart';
import 'package:komikplanet/settings/payment.dart';
// import 'package:komikplanet/settings/cretor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  SettingTile(icon: Icons.person, title: 'Account Settings'),
                  SettingTile(icon: Icons.notifications, title: 'Notification'),
                  SettingTile(icon: Icons.payment, title: 'Payment'),
                  SettingTile(icon: Icons.book, title: 'BoksLish'),
                  SettingTile(icon: Icons.create, title: 'Creator'),
                  SettingTile(icon: Icons.lock, title: 'Change password'),
                  SettingTile(
                      icon: Icons.delete,
                      title: 'Delete Account',
                      isDelete: true),
                ],
              ),
            ),
            LogoutButton(),
          ],
        ),
      ),
      // navigasi di ubah
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Index tab settings
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // Navigasi ke halaman yang sesuai berdasarkan index
        },
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDelete;

  SettingTile({required this.icon, required this.title, this.isDelete = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: isDelete ? Colors.red : Colors.blueGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward, color: Colors.white),
        onTap: () {
          // Handle tap event
        },
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // Handle logout
        },
        icon: Icon(Icons.logout, color: Colors.red),
        label: Text('Logout', style: TextStyle(color: Colors.red)),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.red,
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

  Widget _buildTextField({
    required String label,
    required String initialValue,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextField(
          controller: TextEditingController(text: initialValue),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            isDense: true,
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }