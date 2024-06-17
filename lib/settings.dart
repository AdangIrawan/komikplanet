import 'package:flutter/material.dart';

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
        actions: [
          Icon(Icons.settings),
        ],
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
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