import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geu_bus_driver/firebasemodel.dart';
import 'package:geu_bus_driver/homepage.dart';
import 'package:geu_bus_driver/loginpage.dart';

FirebaseModal model = FirebaseModal();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GEU Bus Driver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
