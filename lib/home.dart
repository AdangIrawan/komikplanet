import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comic Planet'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Banner
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                height: 180.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/image/KomikPlanetLogo.png'), // Replace with your asset image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        'Dark Moon: Children of Vamfield\nwith ENHYPEN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Category
              Text(
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
              Text(
                'Rekomendasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: comics.length, // Set the item count to the length of the comic list
                itemBuilder: (context, index) {
                  return ComicCard(comic: comics[index]);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 17, 0, 58),
        unselectedItemColor: Colors.grey, // Set color for unselected items
        selectedItemColor: Colors.white, // Set color for selected items
        type: BottomNavigationBarType.fixed, // Ensure the background is applied to all items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Library',
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
      ),
    );
  }
}

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
  Comic('assets/image/Komik1.png', 'Doraemon', 'Fantasy', 8.5, 'Doraemon is a Japanese manga series written and illustrated by Fujiko F. Fujio. The series has also been adapted into a successful anime series and media franchise.'),
  Comic('assets/image/Komik2.png', 'Boku No Hiro', 'Action', 9.0, 'Boku No Hero Academia, also known as My Hero Academia, is a Japanese superhero manga series written and illustrated by Kohei Horikoshi.'),
  Comic('assets/image/KomikPlanetLogo.png', 'Gimai Seikatsu', 'Romance', 8.0, 'Gimai Seikatsu is a Japanese manga series that revolves around a romantic story between the main characters.'),
  Comic('assets/image/comic4.png', 'Comic Title 4', 'Comedy', 7.5, 'Description of Comic Title 4. This section can be filled with detailed information about the comic.'),
  Comic('assets/image/comic5.png', 'Comic Title 5', 'Comedy', 7.5, 'Description of Comic Title 5. This section can be filled with detailed information about the comic.'),
  Comic('assets/image/comic6.png', 'Comic Title 6', 'Comedy', 7.5, 'Description of Comic Title 6. This section can be filled with detailed information about the comic.'),
];

class Comic {
  final String imagePath;
  final String title;
  final String genre;
  final double rating;
  final String description;

  const Comic(this.imagePath, this.title, this.genre, this.rating, this.description);
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

class ComicDetailPage extends StatelessWidget {
  final Comic comic;

  const ComicDetailPage({required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(comic.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              comic.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Genre: ${comic.genre}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Rating: ${comic.rating}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              comic.description,
              style: TextStyle(fontSize: 16),
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
