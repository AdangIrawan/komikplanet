import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komikplanet/comicDetail.dart';
import 'Komik.dart';
import 'booklish.dart';
import 'search.dart';
import 'setting.dart';
import 'profile.dart';
import 'notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Comic> comics = [];
  List<Comic> filteredComics = [];
  String selectedGenre = '';
  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _fetchComics();
  }

  Future<void> _fetchComics() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('List Komik')
        .orderBy('timestamp', descending: true)
        .get();
    final fetchedComics = snapshot.docs
        .map((doc) => Comic.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    setState(() {
      comics = fetchedComics;
      filteredComics = fetchedComics;
    });
  }

  void _filterComicsByGenre(String genre) {
    setState(() {
      selectedGenre = genre;
      if (genre == 'All') {
        filteredComics = comics;
      } else {
        filteredComics = comics.where((comic) => comic.genre == genre).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> carouselItems = [
      {
        'imagePath': 'assets/image/Tumbnail1.png',
        'text': 'Tensei Kizoku no Isekai Boukenroku'
      },
      {
        'imagePath': 'assets/image/Tumbnail3.png',
        'text': 'Boku no Hero Academia'
      },
      {'imagePath': 'assets/image/Tumbnail2.png', 'text': 'SPY X FAMILY'},
    ];

    final List<String> categories = [
      'All',
      'Action',
      'Comedy',
      'Drama',
      'Fantasy',
      'Romance',
      'Harem',
      'Slice of Life',
      'Horror',
      'Shounen'

    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/image/KomikPlanetLogo.png'),
        ),
        title: Row(
          children: [
            Text(
              'Planet Komik',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ComicSearchDelegate(comics),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: 180.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {},
                ),
                items: carouselItems.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(item['imagePath']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                item['text']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // Category
              const Text(
                'Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 130,
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CategoryButton(
                        label: categories[index],
                        onTap: () => _filterComicsByGenre(categories[index]),
                        isSelected: selectedGenre == categories[index],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Recommendations
              const Text(
                'Komik Terbaru',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (filteredComics.isEmpty)
                Center(
                  child: Text('No comics found for selected genre.'),
                )
              else
                Column(
                  children: [
                    // Comic Cards with Pagination
                    SizedBox(
                      height: 300, // Adjust height based on your need
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (int index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemCount: (filteredComics.length / 6).ceil(),
                        itemBuilder: (BuildContext context, int pageIndex) {
                          final int startIndex = pageIndex * 6;
                          final int endIndex =
                              (pageIndex + 1) * 6 < filteredComics.length
                                  ? (pageIndex + 1) * 6
                                  : filteredComics.length;

                          final List<Comic> comicsToShow =
                              filteredComics.sublist(startIndex, endIndex);

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: comicsToShow.length,
                            itemBuilder: (context, index) {
                              return ComicCard(comic: comicsToShow[index]);
                            },
                          );
                        },
                      ),
                    ),
                    // Pagination Buttons
                    // Pagination Buttons
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 1.0), // Add top padding here
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0), // Tambahkan padding ke kanan
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: currentPage == 0
                                  ? null
                                  : () {
                                      _pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0), // Tambahkan padding ke kiri
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: currentPage ==
                                      (filteredComics.length / 6).ceil() - 1
                                  ? null
                                  : () {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 11, 1, 35),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
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
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookmarkPage()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RankPage()),
            );
          } else if (index == 3) {
            User user = FirebaseAuth.instance.currentUser!;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
            );
          }
        },
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryButton({
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blueGrey : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class ComicCard extends StatelessWidget {
  final Comic comic;

  const ComicCard({required this.comic});

  bool isNewComic() {
    // Ubah durasi menjadi 5 menit (300 detik)
    final fiveMinutesInMillis = 300 * 1000;

    // Timestamp komik
    final comicTimestamp = comic.timestamp.millisecondsSinceEpoch;

    // Timestamp sekarang
    final nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    // Cek apakah komik masih baru (dibawah 5 menit)
    return (nowTimestamp - comicTimestamp) < fiveMinutesInMillis;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComicDetailPage(comic: comic),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(comic.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    comic.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(comic.genre),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Rating: ${comic.rating}'),
                ),
              ],
            ),
            if (isNewComic()) // Menampilkan label "New" jika komik masih baru
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
