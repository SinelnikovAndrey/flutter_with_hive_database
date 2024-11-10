import 'package:hive/hive.dart';

part 'image_data.g.dart'; 

@HiveType(typeId: 0)
class ImageData {
  @HiveField(0)
  String imagePath;

  ImageData({required this.imagePath});
}