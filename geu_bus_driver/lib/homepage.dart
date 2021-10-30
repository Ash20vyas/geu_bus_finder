import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/graphic_era.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black38),
        ),
        Container(
          child: Column(
            children: [Text("Bus No")],
          ),
        ),
      ],
    )
        // body: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/graphic_era.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child: SafeArea(
        //     child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        //       Text(
        //           "Bus No dfsvjhkbhuk kfgdggggggggggggggggggggggggggggggggggsebkrbher")
        //     ]),
        //   ),
        // ),
        );
  }
}
