import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     body: new Stack(
      //   children: <Widget>[
      //     new Container(
      //       decoration: new BoxDecoration(
      //         image: new DecorationImage(
      //           image: new AssetImage("assets/graphic_era.jpg"),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //     new Center(
      //       child: new Text("Hello background"),
      //     )
      //   ],
      // )
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/graphic_era.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Bus No")]),
        ),
      ),
    );
  }
}
