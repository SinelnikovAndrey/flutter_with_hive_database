import 'package:flutter/material.dart';
import 'package:hive_test/services/image_service.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; 

class ImageListScreen extends StatefulWidget {
  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  final _imageService = ImageService();
  final ImagePicker _picker = ImagePicker(); // Create ImagePicker instance
  XFile? _selectedImage; 

  Future<void> _getImageFromSource(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _selectedImage = pickedImage;
    });

    if (_selectedImage != null) {
      // Save the image path
      await _imageService.saveImagePath(_selectedImage!.path);
      setState(() {}); // Update the UI to show the saved image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
      body: FutureBuilder<String?>(
        future: _imageService.getImagePath(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final imagePath = snapshot.data!;
            return Image.file(
              File(imagePath), 
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a dialog to choose image source
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

// // import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:hive_test/screens/image_upload_screen.dart';
// import 'package:hive_test/services/image_service.dart';
// import 'dart:io';

// // import 'package:image_picker/image_picker.dart'; // Import the 'io' library

// class ImageListScreen extends StatefulWidget {
//   const ImageListScreen({super.key});

//   @override
//   _ImageListScreenState createState() => _ImageListScreenState();
// }

// class _ImageListScreenState extends State<ImageListScreen> {
//   final _imageService = ImageService(); 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Gallery'),
//       ),
//       body: FutureBuilder<String?>(
//         future: _imageService.getImagePath(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final imagePath = snapshot.data!;
//             return Image.file(
//               File(imagePath),
//               height: 300,
//               width: 300,
//               fit: BoxFit.cover,
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//      floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           ImageUploadScreen();
//           // Implement image selection from gallery/camera 
//         },
//         child: const Icon(Icons.add_a_photo),
//       ),
//     );
//   }
  
  // Future<void> _pickImage() async {
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (image == null) return;

  //   Uint8List imageBytes = await image.readAsBytes();
  //   adapter.storeImage(imageBytes);
  // }

  // Future<List<Uint8List>?> _readImagesFromDatabase() async {
  //   return adapter.getImages();
  // }

// }



// import 'package:flutter/material.dart';
// import 'package:hive_test/services/image_service.dart'; // Import the service

// class ImageListScreen extends StatefulWidget {
//   @override
//   _ImageListScreenState createState() => _ImageListScreenState();
// }

// class _ImageListScreenState extends State<ImageListScreen> {
//   final _imageService = ImageService(); // Create an instance of ImageService

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Gallery'),
//       ),
//       body: FutureBuilder<String?>(
//         future: _imageService.getImagePath(), // Use the instance 
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final imagePath = snapshot.data!;
//             return Image.file(
//               imagePath,
//               height: 300, 
//               width: 300,
//               fit: BoxFit.cover,
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Implement image selection from gallery/camera 
//         },
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:hive_test/services/image_service.dart';

// class ImageListScreen extends StatefulWidget {
//   @override
//   _ImageListScreenState createState() => _ImageListScreenState();
// }

// class _ImageListScreenState extends State<ImageListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Gallery'),
//       ),
//       body: FutureBuilder<String?>(
//         future: ImageService.getImagePath(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final imagePath = snapshot.data!;
//             return Image.file(
//               imagePath,
//               height: 300, 
//               width: 300,
//               fit: BoxFit.cover,
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Implement image selection from gallery/camera 
//         },
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }
