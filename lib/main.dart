import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    title: 'Premium Editor',
    theme: ThemeData.dark().copyWith(
      primaryColor: Colors.deepPurple,
      scaffoldBackgroundColor: const Color(0xFF121212),
    ),
    home: PhotoEditorHome(),
    debugShowCheckedModeBanner: false,
  ));
}

class PhotoEditorHome extends StatefulWidget {
  @override
  _PhotoEditorHomeState createState() => _PhotoEditorHomeState();
}

class _PhotoEditorHomeState extends State<PhotoEditorHome> {
  File? _image;
  final _picker = ImagePicker();
  Color _filterColor = Colors.transparent;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _filterColor = Colors.transparent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY PREMIUM EDITOR', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              _image == null
                  ? const Text('সম্পাদনা করতে একটি ছবি যোগ করুন', style: TextStyle(color: Colors.grey, fontSize: 16))
                  : ColorFiltered(
                      colorFilter: ColorFilter.mode(_filterColor, BlendMode.colorBurn),
                      child: Image.file(_image!),
                    ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.black,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: const Icon(Icons.add_photo_alternate, size: 30, color: Colors.deepPurpleAccent), onPressed: _pickImage),
          IconButton(icon: const Icon(Icons.movie_filter, size: 30), onPressed: () => setState(() => _filterColor = Colors.amber.withOpacity(0.3))),
          IconButton(icon: const Icon(Icons.lens, size: 30, color: Colors.blueAccent), onPressed: () => setState(() => _filterColor = Colors.blue.withOpacity(0.2))),
          IconButton(icon: const Icon(Icons.refresh, size: 30, color: Colors.redAccent), onPressed: () => setState(() => _filterColor = Colors.transparent)),
        ],
      ),
    );
  }
}
