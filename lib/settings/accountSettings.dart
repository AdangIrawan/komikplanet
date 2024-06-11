import 'package:flutter/material.dart';


class AccountSettings extends StatelessWidget {
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
        title: Text('Account Settings', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://i.pinimg.com/564x/ec/b8/bc/ecb8bcd9abfa2d3426e2032b0c975e1d.jpg'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Tambahkan logika untuk mengubah gambar profil
                    },
                    child: Text(
                      'Edit profile image',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildTextField(label: 'Username', initialValue: 'Ismail Bin Mail'),
            SizedBox(height: 10),
            _buildTextField(label: 'Email', initialValue: 'maillow@domain.com'),
            SizedBox(height: 10),
            _buildTextField(label: 'URLs', initialValue: 'mail_ganteng45.net'),
            SizedBox(height: 10),
            SizedBox(height: 10),
            SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {
                // Tambahkan logika untuk menambahkan URL lain
              },
              icon: Icon(Icons.add, color: Colors.grey),
              label: Text('Add another', style: TextStyle(color: Colors.grey)),
            ),
            SizedBox(height: 20),
            _buildTextField(
              label: 'Bio',
              initialValue: 'I am a designer based in your heart EAAK, making the best for you.',
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menyimpan perubahan
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Save changes',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
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
}
