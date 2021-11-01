import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geu_bus_driver/designs.dart';
import 'package:hive/hive.dart';

import 'homepage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? phoneNumber;
  var _codeController = TextEditingController();
  void loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();
          var result = await _auth.signInWithCredential(credential);
          var user = result.user;
          if(user != null){
            var b= Hive.box('login');
            print("Sumseccfuly logged in");
            b.put('login',true);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder:(context)=> HomePage()));
          }else{
            Navigator.pop(context);

            final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text('Error has occurred. Please retry again.',style: montserrat(black,h3,FontWeight.w600),));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        verificationFailed: (var exception){ final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error has occurred. Please retry again.',style: montserrat(black,h3,FontWeight.w600),));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId,forceResendingToken){
          showGeneralDialog(
            barrierLabel: "Barrier",
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.15),
            transitionDuration: Duration(milliseconds: 450),
            context: context,
            pageBuilder: (_, __, ___) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Container(
                    height: 200,
                    child: Material(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15,5,15,5),
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.red)
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "OTP",
                              ),
                              controller: _codeController,
                            ),
                          ),
                          InkWell(
                            child: Container(
                                height: 70,
                                margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  color: boxRedText

                                ),
                                child: Center(child: Text("Confirm",style: montserrat(Colors.white,h3,FontWeight.w700),))),
                            onTap: () async{
                              final code = _codeController.text.trim();
                              AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                              var result = await _auth.signInWithCredential(credential);
                              var user = result.user;
                              if(user != null){
                                var b= Hive.box('login');
                                b.put('login',true);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(context,MaterialPageRoute(builder:(context)=> HomePage()));
                                print("Sumseccfuly logged in");
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('Successfully logged in',style: montserrat(black,h3,FontWeight.w600),));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              }else{
                                Navigator.pop(context);
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Error has occurred. Please retry again.',style: montserrat(black,h3,FontWeight.w600),));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                          )
                        ],
                      ),
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
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
                child: child,
              );
            },
          );
        },
        codeAutoRetrievalTimeout:(_){}
    );
  }


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

                ),
                child: Center(
                  child: TextField(
                      onChanged: (value){
                        phoneNumber = value;
                      },
                      decoration: InputDecoration.collapsed(hintText: ""),
                      keyboardType: TextInputType.number,
                      style: poppins(black,h2,FontWeight.w600)
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  loginUser(phoneNumber.toString(),context);
                },
                child: Container(
                  margin: EdgeInsets.only(left:15,right: 15,top: 20,bottom: 30),
                  height: 75,
                  width: 200,
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

