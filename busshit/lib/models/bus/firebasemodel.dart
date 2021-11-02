import 'dart:ffi';
import 'package:busshit/designs/design.dart';
import 'package:busshit/models/map/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  double? time;
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
      transitionDuration: Duration(milliseconds: 450),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(15),
              ),
              child:Container(
                margin:const EdgeInsets.only(top: 40,left:15,right:15),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Text("Next Stop",style: tt(foreground.withOpacity(0.5),h6,FontWeight.w600),)),
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(left: 15,right: 15,),
                        child: Text("Rajput Road Randikhana",style: tt(Colors.green,h2,FontWeight.w600),)),

                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Text("Bus Info".toUpperCase(),style: tt(foreground.withOpacity(0.5),h6,FontWeight.w600),)),
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
              ) ,
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
  Marker createmarker(BuildContext context)  {
    Marker startMarker = RippleMarker(
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
    //check our data object has all values before it goes to cloud.
    if (data.driverName == null ||
        data.busNo == null ||
        data.phoneNumber == null) {
      return false;
    } else {
      instance
          .collection("root")
          .doc(data.busNo.toString())
          .set(data.createMap());
      return true;
    }
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
