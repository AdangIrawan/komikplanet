import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Komik.dart';
import 'booklish.dart';
import 'search.dart';
import 'setting.dart';
import 'profile.dart'; // Import the profile page

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
        'text': 'SPY X FAMLIY'
      },
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
            onPressed: () {
              showSearch(
                context: context,
                delegate: ComicSearchDelegate(),
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
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: comics
                    .length, // Set the item count to the length of the comic list
                itemBuilder: (context, index) {
                  return ComicCard(comic: comics[index]);
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
          if (index == 1) {
            // If the Bookmark icon is clicked, navigate to BookmarkPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookmarkPage()),
            );
          } else if (index == 3) {
            // If the Profile icon is clicked, navigate to ProfilePage
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
              );
            } else {
              // Handle user not logged in
            }
          }
        },
      ),
    );
  }
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
                  image: AssetImage(comic.imagePath), // Use the image path from the comic data
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

class ComicDetailPage extends StatefulWidget {
  final Comic comic;

  const ComicDetailPage({Key? key, required this.comic}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
  String selectedTab = 'Description';
  bool isBookmarked = false;
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
    isBookmarked = Booklish.bookmarkedComics.contains(widget.comic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.comic.title),
        backgroundColor: Color.fromARGB(255, 17, 0, 58),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(widget.comic.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.comic.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Genre: ${widget.comic.genre}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Rating: ${widget.comic.rating}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                  if (userId != null) {
                    if (isBookmarked) {
                      await Booklish.addBookmark(userId!, widget.comic);
                    } else {
                      await Booklish.removeBookmark(userId!, widget.comic);
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Bookmark',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Description';
                    });
                  },
                  child: Text('Description'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Synopsis';
                    });
                  },
                  child: Text('Synopsis'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Status Manga';
                    });
                  },
                  child: Text('Status Manga'),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (selectedTab == 'Description')
              Text(
                widget.comic.description,
                style: TextStyle(fontSize: 16),
              ),
            if (selectedTab == 'Synopsis')
              Text(
                widget.comic.synopsis,
                style: TextStyle(fontSize: 16),
              ),
            if (selectedTab == 'Status Manga')
              Text(
                widget.comic.status,
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            Text(
              'Chapters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.comic.chapters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.comic.chapters[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChapterDetailPage(
                          title: widget.comic.title,
                          chapter: widget.comic.chapters[index].title,
                          images: widget.comic.chapters[index].images,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterDetailPage extends StatelessWidget {
  final String title;
  final String chapter;
  final List<String> images;

  const ChapterDetailPage({
    Key? key,
    required this.title,
    required this.chapter,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title - $chapter'),
        backgroundColor: Color.fromARGB(255, 17, 0, 58),
      ),
      body: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(images[index], fit: BoxFit.contain),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
