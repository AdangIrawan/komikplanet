import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komikplanet/comicDetail.dart';
import 'Komik.dart';
import 'booklish.dart';
import 'search.dart';
import 'setting.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of images and their respective texts
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
        'text': 'SPY X FAMLIY'},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/image/KomikPlanetLogo.png'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
             onPressed: () async {
              final comics = await _fetchComics(); // Fetch comics data
              showSearch(
                context: context,
                delegate: ComicSearchDelegate(comics), // Pass comics data
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
              // Handle settings button press
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
                  onPageChanged: (index, reason) {
                    // Handle page change if necessary
                  },
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
                height: 50, // Set appropriate height here
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 130, // Set fixed width for each category button
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CategoryButton(categories[index]),
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
              FutureBuilder<List<Comic>>(
                future: _fetchComics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final comics = snapshot.data ?? [];
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: comics.length,
                      itemBuilder: (context, index) {
                        return ComicCard(comic: comics[index]);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 11, 1, 35), //color fix
        unselectedItemColor: Colors.grey, // Set color for unselected items
        selectedItemColor: Colors.white, // Set color for selected items
        type: BottomNavigationBarType
            .fixed, // Ensure the background is applied to all items
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
          // Handle bottom navigation bar taps
          if (index == 1) {
            // Jika ikon "Library" diklik, navigasi ke BookmarkPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookmarkPage()),
            );
          }
        },
      ),
    );
  }
}

Future<List<Comic>> _fetchComics() async {
  final snapshot =
      await FirebaseFirestore.instance.collection('List Komik').get();
  return snapshot.docs
      .map((doc) => Comic.fromMap(doc.data() as Map<String, dynamic>))
      .toList();
}

class CategoryButton extends StatelessWidget {
  final String label;

  const CategoryButton(this.label);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle category button press
      },
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
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
                  image: AssetImage(comic
                      .imagePath), // Use the image path from the comic data
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
