import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Komik.dart';

class AddComicPage extends StatefulWidget {
  final Function(Comic) onAddComic;

  AddComicPage({required this.onAddComic});

  @override
  _AddComicPageState createState() => _AddComicPageState();
}

class _AddComicPageState extends State<AddComicPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  void _submitForm() {
  if (_formKey.currentState?.validate() ?? false) {
    final newComic = Comic(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      genre: _genreController.text,
      rating: double.parse(_ratingController.text),
      imagePath: _imagePathController.text,
      description: _descriptionController.text,
      synopsis: _synopsisController.text,
      status: _statusController.text,
      chapters: [],
      timestamp: DateTime.now(), // Add the current time as timestamp
    );

    // Add to Firestore
    FirebaseFirestore.instance.collection('List Komik').add(newComic.toMap())
        .then((_) {
      widget.onAddComic(newComic);
      Navigator.pop(context);
    }).catchError((error) {
      print('Failed to add comic: $error');
      // Handle error, e.g., show a Snackbar or dialog
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Comic'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
                validator: (value) => value!.isEmpty ? 'Please enter a genre' : null,
              ),
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: 'Rating'),
                validator: (value) => value!.isEmpty ? 'Please enter a rating' : null,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _imagePathController,
                decoration: InputDecoration(labelText: 'Image Path'),
                validator: (value) => value!.isEmpty ? 'Please enter an image path' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                controller: _synopsisController,
                decoration: InputDecoration(labelText: 'Synopsis'),
                validator: (value) => value!.isEmpty ? 'Please enter a synopsis' : null,
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) => value!.isEmpty ? 'Please enter a status' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Comic'),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
