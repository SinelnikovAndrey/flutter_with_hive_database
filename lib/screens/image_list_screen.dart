import 'package:flutter/material.dart';
import 'package:hive_test/services/image_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 

class ImageListScreen extends StatefulWidget {
  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  final _imageService = ImageService();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage; 
  List<String> _imagePaths = []; // To store retrieved image paths

  Future<void> _getImageFromSource(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _selectedImage = pickedImage;
    });

    if (_selectedImage != null) {
      // Save the image path
      await _imageService.saveImagePath(_selectedImage!.path);
      setState(() {}); 
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchImages(); // Call the function to retrieve images when the screen loads
  }

  Future<void> _fetchImages() async {
    final imagePaths = await _imageService.getAllImagePaths();
    setState(() {
      _imagePaths = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
      body: _imagePaths.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _imagePaths.length,
              itemBuilder: (context, index) {
                return Image.file(
                  File(_imagePaths[index]),
                  fit: BoxFit.cover,
                );
              },
            )
          : Center(child: Text('No images found')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Choose Image Source'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: () {
                        Navigator.pop(context);
                        _getImageFromSource(ImageSource.gallery);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.pop(context);
                        _getImageFromSource(ImageSource.camera);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}