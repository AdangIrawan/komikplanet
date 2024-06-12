import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Komik.dart';

class AddChapterPage extends StatefulWidget {
  final List<Comic> comics;
  final Function(String, Chapter) onAddChapter;

  AddChapterPage({required this.comics, required this.onAddChapter});

  @override
  _AddChapterPageState createState() => _AddChapterPageState();
}

class _AddChapterPageState extends State<AddChapterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedComicId;
  final TextEditingController _chapterTitleController = TextEditingController();
  final TextEditingController _imagesController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false && _selectedComicId != null) {
      final newChapter = Chapter(
        title: _chapterTitleController.text,
        images: _imagesController.text.split(',').map((image) => image.trim()).toList(),
      );

      // Get reference to the selected comic document
      final selectedComicRef = FirebaseFirestore.instance.collection('List Komik').doc(_selectedComicId!);

      // Use transaction to ensure data consistency
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final selectedComicSnapshot = await transaction.get(selectedComicRef);

        if (selectedComicSnapshot.exists) {
          final selectedComicData = selectedComicSnapshot.data() as Map<String, dynamic>?;

          if (selectedComicData != null && selectedComicData.containsKey('chapters')) {
            List<dynamic>? existingChapters = selectedComicData['chapters'];

            Map<String, dynamic> newChapterData = {
              'title': newChapter.title,
              'images': newChapter.images,
            };

            existingChapters!.add(newChapterData);

            transaction.update(selectedComicRef, {'chapters': existingChapters});

            widget.onAddChapter(_selectedComicId!, newChapter);
            Navigator.pop(context);
          } else {
            print('Failed to add chapter: Chapters data not found in the selected comic');
          }
        } else {
          print('Failed to add chapter: Selected comic does not exist');
        }
      }).catchError((error) {
        print('Failed to add chapter: $error');
        // Handle error, e.g., show a Snackbar or dialog
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Chapter'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // TextFormField for manually entering comic ID
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter Comic ID'),
                onChanged: (value) {
                  setState(() {
                    _selectedComicId = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter a comic ID' : null,
              ),
              TextFormField(
                controller: _chapterTitleController,
                decoration: InputDecoration(labelText: 'Chapter Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a chapter title' : null,
              ),
              TextFormField(
                controller: _imagesController,
                decoration: InputDecoration(labelText: 'Images (comma separated)'),
                validator: (value) => value!.isEmpty ? 'Please enter images' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Chapter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
