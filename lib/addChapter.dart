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

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false && _selectedComicId != null) {
      final newChapter = Chapter(
        title: _chapterTitleController.text,
        images: _imagesController.text.split(',').map((image) => image.trim()).toList(),
      );

      try {
        final selectedComicRef = FirebaseFirestore.instance.collection('List Komik').doc(_selectedComicId);

        final selectedComicSnapshot = await selectedComicRef.get();
        if (!selectedComicSnapshot.exists) {
          throw Exception('Selected comic does not exist');
        }

        final selectedComicData = selectedComicSnapshot.data() as Map<String, dynamic>;
        final existingChapters = (selectedComicData['chapters'] ?? []) as List<dynamic>;

        final newChapterData = {
          'title': newChapter.title,
          'images': newChapter.images,
        };

        existingChapters.add(newChapterData);

        await selectedComicRef.update({'chapters': existingChapters});

        widget.onAddChapter(_selectedComicId!, newChapter);
        Navigator.pop(context);
      } catch (error) {
        print('Failed to add chapter: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add chapter: $error'),
        ));
      }
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('List Komik').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Select Comic'),
                    value: _selectedComicId,
                    items: snapshot.data!.docs.map((DocumentSnapshot document) {
                      return DropdownMenuItem<String>(
                        value: document.id,
                        child: Text(document.id),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedComicId = value;
                      });
                    },
                    validator: (value) => value == null ? 'Please select a comic' : null,
                  );
                },
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
