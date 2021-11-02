import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geu_bus_driver/firebasemodel.dart';
import 'package:geu_bus_driver/homepage.dart';
import 'package:geu_bus_driver/loginpage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

FirebaseModal model = FirebaseModal();



var t ;


void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var box = await Hive.openBox('login');
  t = box.get('login') ?? false;



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GEU Bus Driver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: t ? HomePage() : LoginPage(),
    );
  }
}
