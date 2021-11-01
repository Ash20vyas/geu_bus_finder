import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geu_bus_driver/firebasemodel.dart';
import 'package:geu_bus_driver/homepage.dart';
import 'package:geu_bus_driver/loginpage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

FirebaseModal model = FirebaseModal();

var t;
void main() async {
  Hive.init(await getApplicationDocumentsDirectory().toString());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Hive.boxExists('login').then((value) {
    if (value) {
      var b = Hive.box('login');
      t = b.get('login');
    } else {
      Hive.openBox('login');
      var b = Hive.box('login');
      b.put('login', false);
      t = false;
    }
  });

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
