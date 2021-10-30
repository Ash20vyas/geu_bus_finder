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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 3,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logo(),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Text(
                  "Phone number",
                  style: poppins(black.withOpacity(0.75),h3,FontWeight.normal),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.all(5),
                width: double.infinity,
                margin: EdgeInsets.only(left: 20,right: 20),
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
                child: Center(
                  child: TextField(
                      decoration: InputDecoration.collapsed(hintText: ""),
                      keyboardType: TextInputType.number,
                      style: poppins(black,h2,FontWeight.w600)
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:15,right: 15,top: 30,bottom: 30),
                height: 75,
                width: 250,
                decoration: BoxDecoration(
                  color: boxRed,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    "Get OTP",
                    style: montserrat(boxRedText,h2,FontWeight.w700) ,
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('assets/a.png').image,
                    scale: 0.5
                  )
                ),
              ),
            ],
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
        padding: EdgeInsets.all(20),
        child: RichText(
          text: TextSpan(
              text: 'GEU\n',
              style: montserrat(black.withOpacity(0.5),h3,FontWeight.w600),
              children: <TextSpan>[
                TextSpan(text: 'BUS\n',
                  style: montserrat(logoRed,h1+40,FontWeight.bold),
                ),
                TextSpan(text: 'FINDER\n',
                  style: montserrat(black,h1+50,FontWeight.bold),
                )
              ]
          ),
        )
    );
  }
}

