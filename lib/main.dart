import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/screens/image_list_screen.dart';
// import 'package:hive_test/services/image_service.dart';
import 'package:hive_test/models/image_data.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // await Hive.openBox('images');
  Hive.registerAdapter(ImageDataAdapter()); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Storage with Hive',
      home: ImageListScreen(), 
    );
  }
}