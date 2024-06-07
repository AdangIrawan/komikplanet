// Komik.dart

import 'package:flutter/material.dart';

const List<String> categories = [
  'Fantasy',
  'Action',
  'Romance',
  'Comedy',
  'Horror',
  'Sci-Fi',
  'Drama',
  'Adventure',
];

const List<Comic> comics = [
  Comic(
    'assets/image/Tumbnail1.png',
    'Tensei Kizoku no Isekai Boukenroku',
    'Fantasy',
    8.5,
    'Komik Tensei Kizoku no Isekai Boukenroku ~Jichou wo Shiranai Kamigami no Shito~ merupakan serial Manga yang terbit pertama kali pada tahun 2018, salah satu seri populer karya Yashu yang juga di ilustrasikan oleh Nini. Manga Tensei Kizoku no Isekai Boukenroku ~Jichou wo Shiranai Kamigami no Shito~ telah sukses dan resmi di serialisasikan oleh Beat''s (Mag Garden) . Komik berikut telah ditambah kedalam daftar koleksi Komikcast pada Januari 1, 2024. Chapter terbaru Manga Tensei Kizoku no Isekai Boukenroku ~Jichou wo Shiranai Kamigami no Shito~ telah kami update pada Mei 6, 2024.',
    'Manga Tensei Kizoku no Isekai Boukenroku ~Jichou wo Shiranai Kamigami no Shito~ yang dibuat oleh komikus bernama Yashu ini bercerita tentang Remaja Shiinya Kazuya meninggal saat menyelamatkan gadis-gadis muda dari penyerang, hanya untuk menemukan dirinya bereinkarnasi ke dunia pedang dan sihir. Ini adalah mimpi yang menjadi kenyataan! Meskipun dia ingat kehidupan dan pengetahuannya tentang Bumi, dia sekarang adalah Cain von Silford, putra ketiga seorang bangsawan. Diberikan perlindungan para dewa pada ulang tahunnya yang kelima ternyata merupakan hal yang terlalu baik bagi Kain. Statistik dan peningkatannya sangat kuat, dia harus menyembunyikan kemampuan aslinya untuk naik pangkat di masyarakat saat dia turun ke ruang bawah tanah yang paling gelap. Petualangan isekai terhebat dimulai saat seorang remaja yang berubah menjadi anak-anak terjebak dalam kerajaan indah yang tidak ia ciptakan, namun mungkin suatu hari akan memerintah.',
    ' Status: Berjalan\n Jenis Komik: Manga\n Author: Yashu\n Artis: Nini\n Rilis: 2018\n Serialisasi: Beat''s (Mag Garden)\n Jumlah Pembaca: 12 rb orang',
    [
      Chapter('Chapter 1', [
        'assets/image/Cahapter1.png',
        'assets/image/1.png',
        'assets/image/2.png',
        'assets/image/3.png',
        'assets/image/4.png',
        'assets/image/5.png',
        'assets/image/6.png',
        'assets/image/7.png',
        'assets/image/8.png',
        'assets/image/9.png',
        'assets/image/10.png',
        'assets/image/11.png',
        'assets/image/12.png',
        'assets/image/13.png',
        'assets/image/14.png',
        'assets/image/15.png',
        'assets/image/16.png',
        'assets/image/17.png',
        'assets/image/18.png',
        'assets/image/19.png',
        'assets/image/20.png',
        'assets/image/21.png',
      ]),
      Chapter('Chapter 2', [
        'assets/image/Komik2.png',
        'assets/image/Komik2.png',
      ]),
      Chapter('Chapter 3', [
        'assets/image/KomikPlanetLogo.png',
        'assets/image/KomikPlanetLogo.png',
      ]),
    ],
  ),
  Comic(
    'assets/image/Komik2.png',
    'Boku No Hiro',
    'Action',
    9.0,
    'Boku No Hero Academia, also known as My Hero Academia, is a Japanese superhero manga series written and illustrated by Kohei Horikoshi.',
    'Synopsis of Boku No Hiro.',
    'Status: Ongoing',
    [
      Chapter('Chapter 1', [
        'assets/image/BokuNoHiro1.png',
        'assets/image/BokuNoHiro2.png',
      ]),
      Chapter('Chapter 2', [
        'assets/image/BokuNoHiro3.png',
        'assets/image/BokuNoHiro4.png',
      ]),
      Chapter('Chapter 3', [
        'assets/image/BokuNoHiro5.png',
        'assets/image/BokuNoHiro6.png',
      ]),
    ],
  ),
  Comic(
    'assets/image/KomikPlanetLogo.png',
    'Gimai Seikatsu',
    'Romance',
    8.0,
    'Gimai Seikatsu is a Japanese manga series that revolves around a romantic story between the main characters.',
    'Synopsis of Gimai Seikatsu.',
    'Status: Completed',
    [
      Chapter('Chapter 1', [
        'assets/image/GimaiSeikatsu1.png',
        'assets/image/GimaiSeikatsu2.png',
      ]),
      Chapter('Chapter 2', [
        'assets/image/GimaiSeikatsu3.png',
        'assets/image/GimaiSeikatsu4.png',
      ]),
      Chapter('Chapter 3', [
        'assets/image/GimaiSeikatsu5.png',
        'assets/image/GimaiSeikatsu6.png',
      ]),
    ],
  ),
  Comic(
    'assets/image/Komik1.png',
    'Comic Title 4',
    'Comedy',
    7.5,
    'Description of Comic Title 4. This section can be filled with detailed information about the comic.',
    'Synopsis of Comic Title 4.',
    'Status: Ongoing',
    [
      Chapter('Chapter 1', [
        'assets/image/ComicTitle41.png',
        'assets/image/ComicTitle42.png',
      ]),
      Chapter('Chapter 2', [
        'assets/image/ComicTitle43.png',
        'assets/image/ComicTitle44.png',
      ]),
      Chapter('Chapter 3', [
        'assets/image/ComicTitle45.png',
        'assets/image/ComicTitle46.png',
      ]),
    ],
  ),
  Comic(
    'assets/image/Komik1.png',
    'Comic Title 5',
    'Comedy',
    7.5,
    'Description of Comic Title 5. This section can be filled with detailed information about the comic.',
    'Synopsis of Comic Title 5.',
    'Status: Ongoing',
    [
      Chapter('Chapter 1', [
        'assets/image/ComicTitle51.png',
        'assets/image/ComicTitle52.png',
      ]),
      Chapter('Chapter 2', [
        'assets/image/ComicTitle53.png',
        'assets/image/ComicTitle54.png',
      ]),
      Chapter('Chapter 3', [
        'assets/image/ComicTitle55.png',
        'assets/image/ComicTitle56.png',
      ]),
    ],
  ),
  Comic(
    'assets/image/Komik2.png',
    'Comic Title 6',
    'Comedy',
    7.5,
    'Description of Comic Title 6. This section can be filled with detailed information about the comic.',
    'Synopsis of Comic Title 6.',
    'Status: Ongoing',
    [
      Chapter('Chapter 1', [
        'assets/image/ComicTitle61.png',
        'assets/image/ComicTitle62.png',
      ]),
      Chapter('Chapter 2', [
        'assets/image/ComicTitle63.png',
        'assets/image/ComicTitle64.png',
      ]),
      Chapter('Chapter 3', [
        'assets/image/ComicTitle65.png',
        'assets/image/ComicTitle66.png',
      ]),
    ],
  ),
];

class Comic {
  final String imagePath;
  final String title;
  final String genre;
  final double rating;
  final String description;
  final String synopsis;
  final String status;
  final List<Chapter> chapters;

  const Comic(
    this.imagePath,
    this.title,
    this.genre,
    this.rating,
    this.description,
    this.synopsis,
    this.status,
    this.chapters,
  );
}

class Chapter {
  final String title;
  final List<String> images;

  const Chapter(this.title, this.images);
}
