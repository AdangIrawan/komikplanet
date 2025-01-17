import 'package:cloud_firestore/cloud_firestore.dart';


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
  final DateTime timestamp; // New field

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
    required this.timestamp, // Initialize the new field
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
      timestamp: map['timestamp'] != null 
          ? (map['timestamp'] as Timestamp).toDate() 
          : DateTime.now(), // Use the current date and time as a fallback
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
      'timestamp': Timestamp.fromDate(timestamp), // Convert DateTime to Timestamp
    };
  }
}


class Chapter {
  final String title;
  final String pdfPath; // Tambahkan pdfPath

  const Chapter({
    required this.title,
    required this.pdfPath,
  });

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      title: map['title'] ?? '',
      pdfPath: map['pdfPath'] ?? '', // Sesuaikan dengan nama field pdfPath
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'pdfPath': pdfPath,
    };
  }
}
