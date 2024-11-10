import 'package:hive/hive.dart';
import 'package:hive_test/models/image_data.dart';

class ImageService {
  static const String _imageBoxName = 'images'; 
  late Box<ImageData> _imageBox; // Declare a variable for the box

  ImageService() {
    _initHive(); 
  }

  Future<void> _initHive() async {
    _imageBox = await Hive.openBox<ImageData>(_imageBoxName);
  }

  Future<void> saveImagePath(String imagePath) async {
    // Ensure _imageBox is initialized
    await _initHive(); // Call _initHive() if needed 

    final imageData = ImageData(imagePath: imagePath);
    await _imageBox.put('my_image', imageData);
  }

  Future<String?> getImagePath() async {
    await _initHive(); // Call _initHive() if needed

    final savedImageData = _imageBox.get('my_image');
    return savedImageData?.imagePath; 
  }
}


// import 'package:hive/hive.dart';
// import 'package:hive_test/models/image_data.dart';

// class ImageService {
//   static const String _imageBoxName = 'images'; 
//   late Box<ImageData> _imageBox; // Declare a variable for the box

//   ImageService() {
//     _initHive(); // Initialize Hive and open the box in the constructor
//   }

//   Future<void> _initHive() async {
//     _imageBox = await Hive.openBox<ImageData>(_imageBoxName);
//   }

//   Future<void> saveImagePath(String imagePath) async {
//     final imageData = ImageData(imagePath: imagePath);
//     await _imageBox.put('my_image', imageData);
//   }

//   Future<String?> getImagePath() async {
//     final savedImageData = _imageBox.get('my_image');
//     return savedImageData?.imagePath; 
//   }
// }

// // import 'package:hive/hive.dart';
// // import 'package:hive_test/models/image_data.dart';

// // class ImageService {
// //   static const String _imageBoxName = 'images';
// //   static final Box<ImageData> _imageBox = Hive.box<ImageData>(_imageBoxName);

// //   Future<void> saveImagePath(String imagePath) async {
// //     final imageData = ImageData(imagePath: imagePath);
// //     await _imageBox.put('my_image', imageData);
// //   }

// //   Future<String?> getImagePath() async {
// //     final savedImageData = _imageBox.get('my_image');
// //     return savedImageData?.imagePath; 
// //   }
// // }