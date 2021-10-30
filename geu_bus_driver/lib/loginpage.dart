import 'package:flutter/material.dart';
import 'package:geu_bus_driver/designs.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 3,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Logo(),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 15,right: 15),
            child: Text(
              "Phone number",
              style: montserrat(black.withOpacity(0.6),h3),
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            margin: EdgeInsets.only(left: 15,right: 15),
            decoration: BoxDecoration(
              color: textBoxColor,
              borderRadius:BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey.shade400
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(15),
        child: RichText(
          text: TextSpan(
              text: 'GEU\n',
              style: montserrat(black,h2,FontWeight.normal),
              children: <TextSpan>[
                TextSpan(text: 'BUS\n',
                  style: montserrat(logoRed,h1+30,FontWeight.bold),
                ),
                TextSpan(text: 'FINDER\n',
                  style: montserrat(black,h1+30,FontWeight.bold),
                )
              ]
          ),
        )
    );
  }
}

