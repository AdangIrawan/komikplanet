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

  @override
  void initState() {
    super.initState();
    _fetchComics();
  }

  Future<void> _fetchComics() async {
    final snapshot = await FirebaseFirestore.instance.collection('List Komik').get();
    final fetchedComics = snapshot.docs.map((doc) => Comic.fromMap(doc.data() as Map<String, dynamic>)).toList();
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
      {
        'imagePath': 'assets/image/Tumbnail2.png',
        'text': 'SPY X FAMILY'
      },
    ];

    final List<String> categories = ['All', 'Action', 'Comedy', 'Drama', 'Fantasy', 'Romance'];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Image.asset('assets/image/KomikPlanetLogo.png'),
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
                'Rekomendasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              filteredComics.isEmpty
                  ? Center(
                      child: Text('No comics found for selected genre.'),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredComics.length,
                      itemBuilder: (context, index) {
                        return ComicCard(comic: filteredComics[index]);
                      },
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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
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
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          }
           else if (index == 3) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
