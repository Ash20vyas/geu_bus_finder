import 'package:busshit/designs/design.dart';
import 'package:busshit/models/map/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

var ddd = null;

class Bus {
  late List _stops;
  late String _startTime;
  late String _regNum;
  late int _busNumber;
  late String _driverName;
  late String _phoneNumber;
  late String _timeTaken;
}

class Stop {
  late List coordinates;
  late List buses;
  late String address;
  objectFromMap(dynamic map) {
    coordinates = map['loc'];
    buses = map['buses'];
    address = map['stop'];
  }

  Future dialog(BuildContext context) {
    Widget box(String no) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.centerLeft,
                height: 50,
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    "Bus No. " + no.toString(),
                    style: tt(darkBlue, h3, FontWeight.bold),
                  ),
                )),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade400)),
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: foreground,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(
                      activeBuses[0].phoneNumber.toString(),
                      style: tt(foreground, h5, FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 450),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top:40,left:15,right:15),
              child: Material(
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 350,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius:6,
                          blurRadius: 9,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only( left: 15, right: 15),
                      child: ListView.builder(
                          itemCount: buses.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        address.split(",").first.toUpperCase(),
                                        style: tt(foreground, h2, FontWeight.bold),
                                      )),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        "Buses which go through here",
                                        style: poppins(Colors.grey.shade600, h4,
                                            FontWeight.w600),
                                      )),
                                  InkWell(
                                    onTap: () {
                                      print("===================");
                                      print(buses[index].toString());
                                      if(markers[MarkerId(buses[index].toString())] != null){
                                        mapController!.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                              CameraPosition(target: markers[MarkerId(buses[index].toString())]!.position)
                                          ),
                                        );
                                      }
                                      else{
                                        final snackBar = SnackBar(
                                          duration: Duration(milliseconds: 350),
                                          content: Text('Bus not in service.',style: poppins(Colors.white,h3,FontWeight.w600),),backgroundColor: Colors.red,);
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        box(buses[index].toString()),
                                        Container(
                                            margin: EdgeInsets.only(left: 15),
                                            child: Divider(
                                              color: Colors.grey.shade600,
                                              thickness: 0.5,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return InkWell(
                              onTap: () {
                                print("===================");
                                print(buses[index].toString());
                                if(markers[MarkerId(buses[index].toString())] != null){
                                  mapController!.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(target: markers[MarkerId(buses[index].toString())]!.position)
                                    ),
                                  );
                                }
                                else{
                                  final snackBar = SnackBar(
                                    duration: Duration(milliseconds: 350),
                                    content: Text('Bus not in service.',style: poppins(Colors.white,h3,FontWeight.w600),),backgroundColor: Colors.red,);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                              child: Column(
                                children: [
                                  box(buses[index].toString()),
                                  Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Divider(
                                        color: Colors.grey.shade600,
                                        thickness: 0.5,
                                      ))
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ));
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  Marker createmarker(BuildContext context) {
    Marker startMarker = Marker(
        markerId: MarkerId(address),
        position: LatLng(coordinates[0], coordinates[1]),
        icon: busstop,
        onTap: () async {
          if (ddd == null) {
            ddd = dialog(context);
            await ddd;
            ddd = null;
          } else {
            //do nothing
          }
        });
    return startMarker;
  }
}
