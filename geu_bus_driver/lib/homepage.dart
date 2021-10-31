import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geu_bus_driver/designs.dart';

bool isStarted = false;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var busNo = 15;
  var driverName = "Salman\nKhan";
  var phoneNumber = "1234567890";
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AnimatedContainer(
          duration: Duration(microseconds: 350),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              isStarted ? Color(0xffF08A8A) : Color(0xffC0F9C2),
              isStarted ? Color(0xffF08A8A) : Color(0xffC0F9C2),
              isStarted
                  ? Color(0xffF08A8A).withOpacity(0.2)
                  : Color(0xffC0F9C2).withOpacity(0.2),
            ],
          )),
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            SubHeading(value: "Bus No"),
            Heading(value: busNo.toString()),
            SubHeading(value: "Name"),
            Heading(value: driverName),
            SubHeading(value: "Phone Number"),
            NumHeading(value: phoneNumber),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Checkbox(
                  value: this.isChecked,
                  onChanged: (bool? value) {
                    if (!isStarted) {
                      setState(() {
                        this.isChecked = value!;
                      });
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Text(
                  "I acknowledge that I’m ready to\nstart the bus.",
                  style: poppins(black, h4, FontWeight.normal),
                ),
              )
            ]),
            AnimatedContainer(
              duration: Duration(milliseconds: 350),
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(
                  15,
                  MediaQuery.of(context).size.height * 0.02,
                  15,
                  MediaQuery.of(context).size.height * 0.07),
              decoration: BoxDecoration(
                color: isStarted ? Color(0xffFA9587) : Color(0xff9CE89F),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: TextButton(
                child: Text(isStarted ? "END" : "START",
                    style: montserrat(
                        isStarted ? Color(0xffED4646) : Color(0xff5EA16C),
                        h1 + 15,
                        FontWeight.bold)),
                onPressed: () {
                  if (isStarted) {
                    setState(() {
                      isChecked = false;
                      isStarted = !isStarted;
                    });
                  } else {
                    if (isChecked) {
                      setState(() {
                        isStarted = !isStarted;
                      });
                    } else {
                      final snackBar = SnackBar(
                        content: Text(
                          'Please Acknowledge',
                          style:
                              montserrat(Colors.white, h3, FontWeight.normal),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(milliseconds: 500),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

// ignore: must_be_immutable
class SubHeading extends StatelessWidget {
  String value;
  SubHeading({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 15, top: 20, bottom: 5),
      child: Text(
        value,
        style: montserrat(Colors.grey.shade700, h4),
      ),
    );
  }
}

// ignore: must_be_immutable
class Heading extends StatelessWidget {
  String value;
  Heading({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 15),
      child: AutoSizeText(
        value,
        maxLines: 2,
        style: montserrat(isStarted ? Colors.white : black, h1 + 15),
      ),
    );
  }
}

// ignore: must_be_immutable
class NumHeading extends StatelessWidget {
  String value;
  NumHeading({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 15),
      child: Text(
        value,
        style: montserrat(isStarted ? Colors.white : black, h1 + 7),
      ),
    );
  }
}
