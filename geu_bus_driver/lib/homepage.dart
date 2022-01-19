import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geu_bus_driver/designs.dart';
import 'package:geu_bus_driver/firebasemodel.dart';
import 'package:geu_bus_driver/loginpage.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'main.dart';

bool isStarted = false;

var optionColor = [];

var log = [];
var busNo = -1;
var clearedLogs = false;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Data d = Data();
  var driverName = "";
  var dist = 0.0;
  double total = 0.0;
  bool isChecked = false;
  bool isFuckingLoading = false;
  late String time;
  Position? currentPosition;
  var timer;
  double distance = 0.0;
  List<dynamic> li = [];
  anotherSlave() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();
    log = [];

    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (isStarted) {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.bestForNavigation)
            .then((Position position) async {
          if (currentPosition == null) {
            currentPosition = position;
          } else {
            Position temp = currentPosition!;
            print(temp);
            currentPosition = position;
            double _coordinateDistance(lat1, lon1, lat2, lon2) {
              var p = 0.017453292519943295;
              var c = cos;
              var a = 0.5 -
                  c((lat2 - lat1) * p) / 2 +
                  c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
              return 1000 * 12742 * asin(sqrt(a));
            }

            distance += _coordinateDistance(
              temp.latitude,
              temp.longitude,
              currentPosition!.latitude,
              currentPosition!.longitude,
            );
            if (distance > 2 && busNo != -1) {
              log.add(GeoPoint(position.latitude, position.longitude));
              dist = distance;
              total += dist;
              distance = 0.0;
              d.busNo = busNo;
              d.driverName = driverName;
              d.phoneNumber = phoneNumber;
              d.latitude = currentPosition!.latitude;
              d.longitude = currentPosition!.longitude;
              await model.updateData(d);
              setState(() {});
            }
          }
        }).catchError((e) {
          print(e);
        });
      }
      if (!isStarted) {
        timer.cancel();
      }
    });
  }

  slave() {
    FirebaseFirestore.instance
        .collection('driver')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) async {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        if (phoneNumber == querySnapshot.docs[i]["phoneNumber"]) {
          setState(() {
            driverName = querySnapshot.docs[i]["driverName"];
          });
          break;
        }
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
        appBar: AppBar(
          toolbarHeight: 20,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            isStarted
                ? Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.66,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            bottom: 10, left: 15),
                                        child: Column(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'START TIME',
                                                  style: montserrat(
                                                      Colors.black,
                                                      h4,
                                                      FontWeight.w300),
                                                )),
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  time,
                                                  style: montserrat(black, h4,
                                                      FontWeight.w600),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10, left: 10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'ELAPSED TIME',
                                                    style: montserrat(
                                                        Colors.black,
                                                        h4,
                                                        FontWeight.w300),
                                                  )),
                                              TimerWidget()
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.all(15),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'BUS NO. ' + busNo.toString(),
                                              style: montserrat(black, h1 + 5,
                                                  FontWeight.w300),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 50, left: 15, right: 15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400,
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: Container(
                                      margin: EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 20, top: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "RIDE DETAILS",
                                                style: montserrat(Colors.black,
                                                    h4, FontWeight.w400),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 20, top: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        driverName
                                                            .toUpperCase(),
                                                        style: montserrat(
                                                            Colors.black,
                                                            h2,
                                                            FontWeight.w700),
                                                      )),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        phoneNumber.toString(),
                                                        style: montserrat(
                                                            Colors.black,
                                                            h2,
                                                            FontWeight.w700),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.66,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                            var b = Hive.box('login');
                            b.put('login', false);
                            b.put('phoneNumber', '');
                            final snackBar = SnackBar(
                              duration: Duration(milliseconds: 500),
                              content: Text(
                                "Logged out successfully.",
                                style: montserrat(
                                    Colors.black, h4, FontWeight.bold),
                              ),
                              backgroundColor: Colors.green,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.all(15),
                                height: 65,
                                width: 125,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    'LOGOUT',
                                    style: montserrat(
                                        Colors.black, h4, FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 20, top: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "RIDE DETAILS",
                                      style: montserrat(
                                          Colors.black, h4, FontWeight.w400),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20, top: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              driverName.toUpperCase(),
                                              style: montserrat(Colors.black,
                                                  h2, FontWeight.w700),
                                            )),
                                      ),
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              phoneNumber.toString(),
                                              style: montserrat(Colors.black,
                                                  h2, FontWeight.w700),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isStarted
                      ? Container()
                      : Row(children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(left: 5),
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                if (!isStarted) {
                                  setState(() {
                                    isChecked = value!;
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
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(
                        15,
                        MediaQuery.of(context).size.height * 0.02,
                        15,
                        MediaQuery.of(context).size.height * 0.07),
                    decoration: BoxDecoration(
                      color: isStarted ? logoRed : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
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
                        child: Text(isStarted ? "END" : "START THE TRIP",
                            style: montserrat(
                                isStarted ? Color(0xffED4646) : Colors.black,
                                h2,
                                FontWeight.bold)),
                        onPressed: () {
                          if (isStarted) {
                            setState(() {
                              isChecked = false;
                              isStarted = !isStarted;
                              li.add(busNo);
                              busNo = -1;
                              FirebaseFirestore.instance
                                  .collection("availableBuses")
                                  .doc('zbuJ9U2knTagZWBorKP3')
                                  .set({"busesAvailable": li});
                            });
                          } else {
                            if (isChecked) {
                              void dialogBox(BuildContext context) {
                                showGeneralDialog(
                                    // barrierColor: black.withOpacity(0.3),
                                    context: context,
                                    pageBuilder: (_, __, ___) {
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(
                                              left: 15, right: 15),
                                          alignment: Alignment.center,
                                          height: 300,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade700,
                                                spreadRadius: 6,
                                                blurRadius: 9,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                          ),
                                          child: Material(
                                            child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection("availableBuses")
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  optionColor = List<
                                                          bool>.generate(
                                                      snapshot
                                                          .data!
                                                          .docs[0]
                                                              ['busesAvailable']
                                                          .length,
                                                      (i) => false);
                                                  print(optionColor);
                                                  if (optionColor.length == 0) {
                                                    return Container(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 225,
                                                            child: Center(
                                                              child: Text(
                                                                "No Buses Available",
                                                                style:
                                                                    montserrat(
                                                                        black,
                                                                        h2),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: InkWell(
                                                              child: Container(
                                                                height: 40,
                                                                child: Center(
                                                                    child: Text(
                                                                        "Cancel")),
                                                              ),
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return Column(
                                                      children: [
                                                        Container(
                                                            height: 225,
                                                            child: makeList(
                                                                snapshot:
                                                                    snapshot)),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                child: InkWell(
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Cancel")),
                                                                  ),
                                                                  onTap: () {
                                                                    busNo = -1;
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                child: InkWell(
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Continue")),
                                                                  ),
                                                                  onTap: () {
                                                                    if (busNo ==
                                                                        -1) {
                                                                      Navigator.pop(
                                                                          context);
                                                                      var snackbar = SnackBar(
                                                                          backgroundColor: Colors.red,
                                                                          content: Text(
                                                                            "Select a bus first.",
                                                                            style: montserrat(
                                                                                Colors.white,
                                                                                h3,
                                                                                FontWeight.w600),
                                                                          ));
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              snackbar);
                                                                    } else {
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {
                                                                        time = DateFormat.jm()
                                                                            .format(DateTime.now());
                                                                        isStarted =
                                                                            !isStarted;
                                                                        li = snapshot
                                                                            .data!
                                                                            .docs[0]['busesAvailable'];
                                                                        li.remove(
                                                                            busNo);
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "availableBuses")
                                                                            .doc(
                                                                                'zbuJ9U2knTagZWBorKP3')
                                                                            .set({
                                                                          "busesAvailable":
                                                                              li
                                                                        });
                                                                        anotherSlave();
                                                                      });
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  }
                                                  ;
                                                } else {
                                                  return CircularProgressIndicator();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }

                              dialogBox(context);
                            } else {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Please Acknowledge',
                                  style: montserrat(
                                      Colors.white, h3, FontWeight.normal),
                                ),
                                backgroundColor: Colors.red,
                                duration: Duration(milliseconds: 500),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        }),
                  ),
                ],
              ),
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
      margin: EdgeInsets.only(left: 15, bottom: 5, right: 15),
      child: Text(
        value,
        style: montserrat(Colors.grey.shade500, h4),
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
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 15, right: 15),
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

class makeList extends StatefulWidget {
  dynamic snapshot;

  makeList({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  _makeListState createState() => _makeListState();
}

class _makeListState extends State<makeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.snapshot.data!.docs[0]['busesAvailable'].length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                    child: Text("All available buses",
                        style: montserrat(Colors.black, h2)),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15, bottom: 5),
                    child: Text(
                      "Select the bus assigned to you",
                      style: montserrat(Colors.grey.shade400, h5),
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: optionColor[index] ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          optionColor = List<bool>.generate(
                              widget.snapshot.data!.docs[0]['busesAvailable']
                                  .length,
                              (i) => false);
                          optionColor[index] = true;
                          busNo = widget.snapshot.data!.docs[0]
                              ['busesAvailable'][index];
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Bus No. " +
                              widget.snapshot.data!
                                  .docs[0]['busesAvailable'][index]
                                  .toString(),
                          style: montserrat(
                              optionColor[index] ? Colors.white : black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container(
            height: 30,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: optionColor[index] ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade400)),
            child: InkWell(
              onTap: () {
                print("!");
                setState(() {
                  optionColor = List<bool>.generate(
                      widget.snapshot.data!.docs[0]['busesAvailable'].length,
                      (i) => false);
                  optionColor[index] = true;
                  busNo =
                      widget.snapshot.data!.docs[0]['busesAvailable'][index];
                });
              },
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Bus No. " +
                      widget.snapshot.data!.docs[0]['busesAvailable'][index]
                          .toString(),
                  style: montserrat(optionColor[index] ? Colors.white : black),
                ),
              ),
            ),
          );
        });
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  var initTime = DateTime.now();
  Timer? _timer;
  int _start = 0;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (!isStarted) {
          _timer!.cancel();
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  String calc(_start) {
    String sec = (_start % 60).toString();
    if (sec.length == 1) {
      sec = '0' + sec;
    }
    int min = _start ~/ 60;
    String hrs = (min ~/ 60).toString();
    if (hrs.length == 1) {
      hrs = '0' + hrs;
    }
    String mn = (min % 60).toString();
    if (mn.length == 1) {
      mn = '0' + mn;
    }
    return hrs + ':' + mn + ':' + sec;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.all(15),
        child: Text(
          calc(_start),
          style: montserrat(black, h4, FontWeight.w600),
        ));
  }
}
