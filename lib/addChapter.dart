import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'komik.dart';

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
  String? _pdfPath;

  Future<void> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        _pdfPath = result.files.single.path;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false && _pdfPath != null) {
      final newChapter = Chapter(
        title: _chapterTitleController.text,
        pdfPath: _pdfPath!,
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
          'pdfPath': newChapter.pdfPath,
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
    } else if (_pdfPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a PDF file'),
      ));
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
              ElevatedButton(
                onPressed: _pickPdfFile,
                child: Text(_pdfPath == null ? 'Select PDF File' : 'PDF Selected'),
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
