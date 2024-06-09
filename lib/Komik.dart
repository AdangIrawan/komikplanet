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

class Comic {
  final String id;
  final String title;
  final String genre;
  final double rating;
  final String imagePath;
  final String description;
  final String synopsis;
  final String status;
  final List<Chapter> chapters;

  const Comic({
    required this.id,
    required this.title,
    required this.genre,
    required this.rating,
    required this.imagePath,
    required this.description,
    required this.synopsis,
    required this.status,
    required this.chapters,
  });

  factory Comic.fromMap(Map<String, dynamic> map) {
    return Comic(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      genre: map['genre'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      imagePath: map['imagePath'] ?? '',
      description: map['description'] ?? '',
      synopsis: map['synopsis'] ?? '',
      status: map['status'] ?? '',
      chapters: List<Chapter>.from(
        (map['chapters'] ?? []).map((item) => Chapter.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'rating': rating,
      'imagePath': imagePath,
      'description': description,
      'synopsis': synopsis,
      'status': status,
      'chapters': chapters.map((chapter) => chapter.toMap()).toList(),
    };
  }
}

class Chapter {
  final String title;
  final List<String> images;

  const Chapter({
    required this.title,
    required this.images,
  });

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      title: map['title'] ?? '',
      images: List<String>.from(map['images'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'images': images,
    };
  }
}

const List<Comic> comics = [
  Comic(
    id: '1',
    title: 'Tensei Kizoku no Isekai Boukenroku',
    genre: 'Fantasy',
    rating: 8.5,
    imagePath: 'assets/image/Tumbnail1.png',
    description: 'Komik Tensei Kizoku no Isekai Boukenroku Jichou wo Shiranai Kamigami no Shito merupakan serial Manga yang terbit pertama kali pada tahun 2018, salah satu seri populer karya Yashu yang juga di ilustrasikan oleh Nini. Manga Tensei Kizoku no Isekai Boukenroku Jichou wo Shiranai Kamigami no Shito telah sukses dan resmi di serialisasikan oleh Beat''s (Mag Garden) . Komik berikut telah ditambah kedalam daftar koleksi Komikcast pada Januari 1, 2024. Chapter terbaru Manga Tensei Kizoku no Isekai Boukenroku Jichou wo Shiranai Kamigami no Shito telah kami update pada Mei 6, 2024.',
    synopsis: 'Manga Tensei Kizoku no Isekai Boukenroku Jichou wo Shiranai Kamigami no Shito yang dibuat oleh komikus bernama Yashu ini bercerita tentang Remaja Shiinya Kazuya meninggal saat menyelamatkan gadis-gadis muda dari penyerang, hanya untuk menemukan dirinya bereinkarnasi ke dunia pedang dan sihir. Ini adalah mimpi yang menjadi kenyataan! Meskipun dia ingat kehidupan dan pengetahuannya tentang Bumi, dia sekarang adalah Cain von Silford, putra ketiga seorang bangsawan. Diberikan perlindungan para dewa pada ulang tahunnya yang kelima ternyata merupakan hal yang terlalu baik bagi Kain. Statistik dan peningkatannya sangat kuat, dia harus menyembunyikan kemampuan aslinya untuk naik pangkat di masyarakat saat dia turun ke ruang bawah tanah yang paling gelap. Petualangan isekai terhebat dimulai saat seorang remaja yang berubah menjadi anak-anak terjebak dalam kerajaan indah yang tidak ia ciptakan, namun mungkin suatu hari akan memerintah.',
    status: 'Status: Berjalan\nJenis Komik: Manga\nAuthor: Yashu\nArtis: Nini\nRilis: 2018\nSerialisasi: Beat\'s (Mag Garden)\nJumlah Pembaca: 12 rb orang',
    chapters: [
      Chapter(
        title: 'Chapter 1',
        images: [
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
        ],
      ),
      Chapter(
        title: 'Chapter 2',
        images: [
          'assets/image/Komik2.png',
          'assets/image/Komik2.png',
        ],
      ),
      Chapter(
        title: 'Chapter 3',
        images: [
          'assets/image/KomikPlanetLogo.png',
          'assets/image/KomikPlanetLogo.png',
        ],
      ),
    ],
  ),
  Comic(
    id: '2',
    title: 'Boku No Hiro',
    genre: 'Action',
    rating: 9.0,
    imagePath: 'assets/image/Komik2.png',
    description: 'Boku No Hero Academia, also known as My Hero Academia, is a Japanese superhero manga series written and illustrated by Kohei Horikoshi.',
    synopsis: 'Synopsis of Boku No Hiro.',
    status: 'Status: Ongoing',
    chapters: [
      Chapter(
        title: 'Chapter 1',
        images: [
          'assets/image/BokuNoHiro1.png',
          'assets/image/BokuNoHiro2.png',
        ],
      ),
      Chapter(
        title: 'Chapter 2',
        images: [
          'assets/image/BokuNoHiro3.png',
          'assets/image/BokuNoHiro4.png',
        ],
      ),
      Chapter(
        title: 'Chapter 3',
        images: [
          'assets/image/BokuNoHiro5.png',
          'assets/image/BokuNoHiro6.png',
        ],
      ),
    ],
  ),
  Comic(
    id: '3',
    title: 'Gimai Seikatsu',
    genre: 'Romance',
    rating: 8.0,
    imagePath: 'assets/image/KomikPlanetLogo.png',
    description: 'Gimai Seikatsu is a Japanese manga series that revolves around a romantic story between the main characters.',
    synopsis: 'Synopsis of Gimai Seikatsu.',
    status: 'Status: Completed',
    chapters: [
      Chapter(
        title: 'Chapter 1',
        images: [
          'assets/image/GimaiSeikatsu1.png',
          'assets/image/GimaiSeikatsu2.png',
        ],
      ),
      Chapter(
        title: 'Chapter 2',
        images: [
          'assets/image/GimaiSeikatsu3.png',
          'assets/image/GimaiSeikatsu4.png',
        ],
      ),
      Chapter(
        title: 'Chapter 3',
        images: [
          'assets/image/GimaiSeikatsu5.png',
          'assets/image/GimaiSeikatsu6.png',
        ],
      ),
    ],
  ),
  Comic(
    id: '4',
    title: 'Comic Title 4',
    genre: 'Comedy',
    rating: 7.5,
    imagePath: 'assets/image/Komik1.png',
    description: 'Description of Comic Title 4. This section can be filled with detailed information about the comic.',
    synopsis: 'Synopsis of Comic Title 4.',
    status: 'Status: Ongoing',
    chapters: [
      Chapter(
        title: 'Chapter 1',
        images: [
          'assets/image/ComicTitle41.png',
          'assets/image/ComicTitle42.png',
        ],
      ),
      Chapter(
        title: 'Chapter 2',
        images: [
          'assets/image/ComicTitle43.png',
          'assets/image/ComicTitle44.png',
        ],
      ),
      Chapter(
        title: 'Chapter 3',
        images: [
          'assets/image/ComicTitle45.png',
          'assets/image/ComicTitle46.png',
        ],
      ),
    ],
  ),
  Comic(
    id: '5',
    title: 'Comic Title 5',
    genre: 'Comedy',
    rating: 7.5,
    imagePath: 'assets/image/Komik1.png',
    description: 'Description of Comic Title 5. This section can be filled with detailed information about the comic.',
    synopsis: 'Synopsis of Comic Title 5.',
    status: 'Status: Ongoing',
    chapters: [
      Chapter(
        title: 'Chapter 1',
        images: [
          'assets/image/ComicTitle51.png',
          'assets/image/ComicTitle52.png',
        ],
      ),
      Chapter(
        title: 'Chapter 2',
        images: [
          'assets/image/ComicTitle53.png',
          'assets/image/ComicTitle54.png',
        ],
      ),
      Chapter(
        title: 'Chapter 3',
        images: [
          'assets/image/ComicTitle55.png',
          'assets/image/ComicTitle56.png',
        ],
      ),
    ],
  ),
  Comic(
    id: '6',
    title: 'Comic Title 6',
    genre: 'Comedy',
    rating: 7.5,
    imagePath: 'assets/image/Komik2.png',
    description: 'Description of Comic Title 6. This section can be filled with detailed information about the comic.',
    synopsis: 'Synopsis of Comic Title 6.',
    status: 'Status: Ongoing',
    chapters: [
      Chapter(
        title: 'Chapter 1',
        images: [
          'assets/image/ComicTitle61.png',
          'assets/image/ComicTitle62.png',
        ],
      ),
      Chapter(
        title: 'Chapter 2',
        images: [
          'assets/image/ComicTitle63.png',
          'assets/image/ComicTitle64.png',
        ],
      ),
      Chapter(
        title: 'Chapter 3',
        images: [
          'assets/image/ComicTitle65.png',
          'assets/image/ComicTitle66.png',
        ],
      ),
    ],
  ),
];
