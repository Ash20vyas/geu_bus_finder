

import 'package:busshit/designs/design.dart';
import 'package:busshit/models/map/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data.dart';
var dd = null;
class Data {
  late String driverName;
  late num busNo;
  late String phoneNumber;
  late double latitude;
  late double longitude;
  late double total;
  String? areaName;
  late MarkerId marker = MarkerId(busNo.toString());
  double? time = 999999;
  double? collegeReachTime;
  //data goes to cloud in the form of map. so creating a map before is a efficient process
  createMap() {
    return {
      "driverName": driverName,
      "busNo": busNo,
      "phoneNumber": phoneNumber,
      "latitude": latitude,
      "longitude": longitude,
      "total": total,
    };
  }



  Future dialog(BuildContext context){

    return showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 450),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment:Alignment.topCenter,
          child: Container(
            height: 220,
            margin: EdgeInsets.only(left:15,right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius:6,
                  blurRadius: 9,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Material(
              child: Container(
                margin: const EdgeInsets.only( left: 5, right: 5,top: 20,bottom: 20),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Text("Bus Info".toUpperCase(),style: tt(foreground.withOpacity(0.5),h5,FontWeight.w600),)),
                    Container(
                      margin: const EdgeInsets.only(top:10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(left:15,right: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey.shade400)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  Icon(Icons.bus_alert_rounded,color: foreground,),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text("Bus No." + busNo.toString(),style: tt(foreground,h4,FontWeight.w600),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(right:15,left: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey.shade400)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  Icon(Icons.contacts_rounded,color: foreground,),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text(driverName.split(" ").first,style: tt(foreground,h4,FontWeight.w600),),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(right: 15, left: 15,bottom:12.5,top: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade400)),
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
                              phoneNumber,
                              style: tt(foreground, h4, FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
  Marker createmarker(BuildContext context)  {
    Marker startMarker = Marker(
      markerId: MarkerId(busNo.toString()),
      position: LatLng(latitude,longitude),
      icon:busicon,
      onTap: () async {
        if (dd == null) {
          dd = dialog(context);
          await dd;
          dd = null;
        } else {
          //do nothing
        }

      }
    );
    return startMarker;
  }
}

class FirebaseModal {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  bool updateData(Data data) {

      instance
          .collection("root")
          .doc(data.busNo.toString())
          .set(data.createMap());
      return true;

  }

  // void dataUpdate() {
  //   for (int i = 0; i < busData.length; i++) {
  //     instance
  //         .collection("busData")
  //         .doc(busData[i]['bus'].toString())
  //         .set(busData[i]);
  //   }
  // }
}
