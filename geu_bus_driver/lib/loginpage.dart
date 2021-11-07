import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geu_bus_driver/designs.dart';
import 'package:geu_bus_driver/main.dart';
import 'package:hive/hive.dart';

import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLoadingScreen = false;
  bool otpScreen = false;
  var _codeController = TextEditingController();
  void loginUser(String phone, BuildContext context,
      [dynamic resending]) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    setState(() {
      showLoadingScreen = true;
    });
    _auth.verifyPhoneNumber(
        forceResendingToken: resending ?? null,
        phoneNumber: "+91" + phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          var result = await _auth.signInWithCredential(credential);
          var user = result.user;
          if (user != null) {
            var b = Hive.box('login');
            b.put('login', true);
            b.put('phoneNumber', phoneNumber);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            Navigator.pop(context);
            setState(() {
              showLoadingScreen = false;
            });
            final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Error has occurred. Please retry again.1',
                  style: montserrat(Colors.white, h4, FontWeight.w600),
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        verificationFailed: (var exception) {
          setState(() {
            showLoadingScreen = false;
          });
          final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Error has occurred. Please retry again.2',
                style: montserrat(Colors.white, h4, FontWeight.w600),
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId, forceResendingToken) {
          setState(() {
            showLoadingScreen = false;
            otpScreen = true;
          });
          showGeneralDialog(
            barrierLabel: "Barrier",
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.15),
            transitionDuration: Duration(milliseconds: 450),
            context: context,
            pageBuilder: (_, __, ___) {
              return Align(
                alignment: Alignment.center,
                child: Material(
                  child: Container(
                    height: 285,
                    margin: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Material(
                          child: Container(
                            margin: EdgeInsets.all(15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Enter the One Time Password (OTP) received on your device.",
                              style: montserrat(
                                  Colors.grey.shade600, h4, FontWeight.w500),
                            ),
                          ),
                        ),
                        Material(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.red)),
                            child: TextField(
                              style: montserrat(black, h3, FontWeight.bold),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "OTP",
                                  labelStyle:
                                      montserrat(black, h4, FontWeight.w600)),
                              controller: _codeController,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showLoadingScreen = false;
                                      otpScreen = false;
                                    });
                                    Navigator.pop(context);
                                    loginUser(
                                        phone, context, forceResendingToken);
                                  },
                                  child: Text(
                                    "Resend OTP?",
                                    style: montserrat(
                                        Colors.blue, h5, FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 5),
                          child: InkWell(
                            child: Container(
                                height: 70,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: boxRedText),
                                child: Center(
                                    child: Text(
                                  "Confirm",
                                  style: montserrat(
                                      Colors.white, h3, FontWeight.w700),
                                ))),
                            onTap: () async {
                              final code = _codeController.text.trim();
                              AuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: code);
                              try {
                                var result = await _auth
                                    .signInWithCredential(credential);
                                var user = result.user;
                                if (user != null) {
                                  var b = Hive.box('login');
                                  b.put('login', true);
                                  b.put('phoneNumber', phoneNumber);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                  final snackBar = SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Successfully logged in',
                                        style: montserrat(
                                            Colors.white, h4, FontWeight.w600),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Navigator.pop(context);
                                  final snackBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Error has occurred. Please retry again.3',
                                        style: montserrat(
                                            Colors.white, h4, FontWeight.w600),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                setState(() {
                                  otpScreen = false;
                                });
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Recheck your OTP',
                                      style: montserrat(
                                          Colors.white, h4, FontWeight.w600),
                                    ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              );
            },
            transitionBuilder: (_, anim, __, child) {
              return SlideTransition(
                position:
                    Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
                child: child,
              );
            },
          );
        },
        codeAutoRetrievalTimeout: (_) {});
  }

  List<String> drivers = [];

  void slave() {
    FirebaseFirestore.instance
        .collection('driver')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) async {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        drivers.add(querySnapshot.docs[i]['phoneNumber']);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    slave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: !otpScreen,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 3,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 350),
        child: showLoadingScreen
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "Phone number",
                          style: montserrat(
                              black.withOpacity(0.75), h4, FontWeight.w600),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: textBoxColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: TextField(
                              onChanged: (value) {
                                phoneNumber = value;
                              },
                              decoration:
                                  InputDecoration.collapsed(hintText: ""),
                              keyboardType: TextInputType.number,
                              style: poppins(black, h2, FontWeight.w600)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 30),
                        child: InkWell(
                          onTap: () {
                            if (phoneNumber.length < 10 ||
                                !drivers.contains(phoneNumber)) {
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 350),
                                content: Text(
                                  'Not a valid phone number!',
                                  style: montserrat(
                                      Colors.white, h4, FontWeight.normal),
                                ),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              loginUser(phoneNumber.toString(), context);
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                                color: boxRed,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Get OTP",
                                style:
                                    montserrat(boxRedText, h3, FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.asset('assets/a.png').image,
                                scale: 0.3)),
                      ),
                    ],
                  )
                ],
              ),
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
              style: montserrat(black.withOpacity(0.4), h4, FontWeight.w600),
              children: <TextSpan>[
                TextSpan(
                  text: 'BUS\n',
                  style: montserrat(Colors.red.shade900.withOpacity(0.85),
                      h1 + 30, FontWeight.bold),
                ),
                TextSpan(
                  text: 'FINDER\n',
                  style: montserrat(black, h1 + 50, FontWeight.bold),
                )
              ]),
        ));
  }
}
