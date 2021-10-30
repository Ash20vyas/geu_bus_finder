import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var busNo = 15;
  var driverName = "Mia Khalifa";
  var phoneNumber = "6969696969";
  var boxColor = Colors.green[300];
  var altBoxColor = Colors.red[300];
  var boxWord = "START";
  var altBoxWord = "END";

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
        Column(
          children: [
            Text("Bus No"),
            Text(busNo.toString()),
            Text("Name"),
            Text(driverName),
            Text("Phone Number"),
            Text(phoneNumber),
          ],
        ),
        Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(color: boxColor),
            alignment: Alignment.bottomCenter,
            child: TextButton(
              child: Text(boxWord),
              onPressed: () {
                setState(() {
                  var x = boxColor;
                  boxColor = altBoxColor;
                  altBoxColor = x;
                  var y = boxWord;
                  boxWord = altBoxWord;
                  altBoxWord = y;
                });
              },
            )),
      ],
    ));
  }
}
