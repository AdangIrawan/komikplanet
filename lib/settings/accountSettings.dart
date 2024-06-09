import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          _buildSettingsItem(
            icon: Icons.person,
            text: 'Account Settings',
            onTap: () {
              // Navigasi ke halaman Account Settings
            },
          ),
          _buildSettingsItem(
            icon: Icons.notifications,
            text: 'Notification',
            onTap: () {
              // Navigasi ke halaman Notification
            },
          ),
          _buildSettingsItem(
            icon: Icons.payment,
            text: 'Payment',
            onTap: () {
              // Navigasi ke halaman Payment
            },
          ),
          _buildSettingsItem(
            icon: Icons.book,
            text: 'BoksLish',
            onTap: () {
              // Navigasi ke halaman BoksLish
            },
          ),
          _buildSettingsItem(
            icon: Icons.brush,
            text: 'Creator',
            onTap: () {
              // Navigasi ke halaman Creator
            },
          ),
          _buildSettingsItem(
            icon: Icons.lock,
            text: 'Change password',
            onTap: () {
              // Navigasi ke halaman Change password
            },
          ),
          _buildSettingsItem(
            icon: Icons.delete,
            text: 'Delete Account',
            textColor: Colors.red,
            backgroundColor: Colors.red.shade100,
            onTap: () {
              // Navigasi ke halaman Delete Account
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Logout action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,  // Index of the settings tab
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

  Widget _buildSettingsItem({
    required IconData icon,
    required String text,
    Color textColor = Colors.black,
    Color backgroundColor = Colors.white,
    required Function onTap,
  }) {
    return Card(
      color: backgroundColor,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: textColor),
        onTap: () => onTap(),
      ),
    );
  }
}
