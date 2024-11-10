import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_test/services/image_service.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  
  final _imageService = ImageService();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImage != null)
              Image.file(
                File(_selectedImage!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Select Image from Gallery'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedImage != null
                  ? () {
                      // Save the image path
                      _imageService.saveImagePath(_selectedImage!.path)
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Image Saved!')),
                        );
                        Navigator.pop(context); // Go back to image list
                      });
                    }
                  : null,
              child: Text('Save Image'),
            ),
          ],
        ),
      ),
    );
  }
}