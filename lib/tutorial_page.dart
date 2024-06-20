import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutorial Membaca Komik',
          style: TextStyle(color: Colors.white), // Change text color here
        ),
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cara Membaca Komik',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '1. Buka aplikasi komik.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '2. Pilih judul komik yang ingin dibaca.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '3. Pilih Chapter yang ingin dibaca. (Disarankan untuk komik yang baru pertama kali dibaca untuk memilih dari "chapter 1" agar mengerti alur cerita.)',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '4. Jika suka dengan komik yang kamu baca tetapi kamu ingin melanjutkan baca di waktu yang lain, kamu dapat menambahkan komik ke dalam bookmark.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '5. Kamu dapat mencari komik yang ingin kamu baca melalui "Icon Search".',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '6. Kamu dapat memilih genre komik yang ingin kamu baca dengan button filter yang ada di halaman utama. ',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '7. Jika kamu ingin memilih membaca komik melalui peringkat komik terpopuler, kamu dapat menekan navigation bar "ranking" untuk melihat peringkat komik terpopuler.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
