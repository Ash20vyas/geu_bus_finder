import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geu_bus_driver/designs.dart';
import 'package:geu_bus_driver/firebasemodel.dart';

import 'main.dart';

bool isStarted = false;

var optionColor = [];

var busNo = -1;

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

  Position? currentPosition;
  var timer;
  double distance = 0.0;
  anotherSlave() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (isStarted) {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.bestForNavigation)
            .then((Position position) async {
          Position? temp = currentPosition;
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
            temp!.latitude,
            temp.longitude,
            currentPosition!.latitude,
            currentPosition!.longitude,
          );
          if (distance > 2) {
            dist = distance;
            total += dist;
            distance = 0.0;
            d.busNo = busNo;
            d.driverName = driverName;
            d.phoneNumber = phoneNumber;
            d.latitude = currentPosition!.latitude;
            d.longitude = currentPosition!.longitude;
            d.total = total;
            await model.updateData(d);
            setState(() {});
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
        body: Stack(
      children: [
        AnimatedContainer(
          duration: Duration(microseconds: 350),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              isStarted ? Color(0xffF08A8A) : Colors.white,
              isStarted ? Color(0xffF08A8A) : Colors.white,
              isStarted ? Color(0xffF08A8A).withOpacity(0.2) : Colors.white,
            ],
          )),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 350),
          child: isStarted
              ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      SubHeading(value: "Name"),
                      Heading(value: driverName),
                      SubHeading(value: "Time Elapsed"),
                      TimerWidget(),
                      SubHeading(value: "Bus No."),
                      Heading(
                        value: busNo.toString(),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SubHeading(value: "Name"),
                    Heading(value: driverName),
                  ],
                ),
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
                      void dialogBox(BuildContext context) {
                        showGeneralDialog(
                            // barrierColor: black.withOpacity(0.3),
                            context: context,
                            pageBuilder: (_, __, ___) {
                              return Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  alignment: Alignment.center,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade700,
                                        spreadRadius: 6,
                                        blurRadius: 9,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Material(
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("availableBuses")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          optionColor = List<bool>.generate(
                                              snapshot
                                                  .data!
                                                  .docs[0]['busesAvailable']
                                                  .length,
                                              (i) => false);
                                          print(optionColor);
                                          return Column(
                                            children: [
                                              Container(
                                                  height: 225,
                                                  child: makeList(
                                                      snapshot: snapshot)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    child: Container(
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
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: InkWell(
                                                        child: Container(
                                                          height: 40,
                                                          child: Center(
                                                              child: Text(
                                                                  "Continue")),
                                                        ),
                                                        onTap: () {
                                                          if (busNo == -1) {
                                                            Navigator.pop(
                                                                context);
                                                            var snackbar =
                                                                SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content:
                                                                        Text(
                                                                      "Select a bus first.",
                                                                      style: montserrat(
                                                                          Colors
                                                                              .white,
                                                                          h3,
                                                                          FontWeight
                                                                              .w600),
                                                                    ));
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackbar);
                                                          } else {
                                                            print(busNo);
                                                            print(driverName);
                                                            print(phoneNumber);
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {
                                                              isStarted =
                                                                  !isStarted;
                                                              slave();
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

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.all(15),
        child: Text(
          _start.toString() + " seconds",
          style: montserrat(Colors.black, h2, FontWeight.bold),
        ));
  }
}
