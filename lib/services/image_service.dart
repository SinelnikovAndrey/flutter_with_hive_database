import 'package:hive/hive.dart';
import 'package:hive_test/models/image_data.dart';

class ImageService {
  static const String _imageBoxName = 'images'; 
  late Box<ImageData> _imageBox; 

  ImageService() {
    _initHive(); 
  }

  Future<void> _initHive() async {
    _imageBox = await Hive.openBox<ImageData>(_imageBoxName);
  }

  Future<void> saveImagePath(String imagePath) async {
    await _initHive(); 

    // Generate a unique key (you can use a timestamp or a counter)
    final key = DateTime.now().millisecondsSinceEpoch.toString();

    final imageData = ImageData(imagePath: imagePath);
    await _imageBox.put(key, imageData); // Save with a unique key
  }

  Future<List<String>> getAllImagePaths() async {
    await _initHive();
    List<String> imagePaths = [];
    for (var key in _imageBox.keys) {
      final imageData = _imageBox.get(key);
      if (imageData != null) {
        imagePaths.add(imageData.imagePath);
      }
    }
    return imagePaths;
  }
}