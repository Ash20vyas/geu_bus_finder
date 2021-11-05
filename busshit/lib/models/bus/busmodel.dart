import 'package:busshit/designs/design.dart';
import 'package:busshit/models/map/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

var ddd;

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
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Container(
                  margin: const EdgeInsets.all(5),
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
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: foreground,
                  ),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        activeBuses[0].phoneNumber.toString(),
                        style: tt(foreground, h5, FontWeight.w600),
                      ),
                    ),
                    onTap: () async {
                      await launch(
                          "tel:" + activeBuses[0].phoneNumber.toString());
                    },
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
      transitionDuration: const Duration(milliseconds: 450),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 6,
                          blurRadius: 9,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 20),
                      child: ListView.builder(
                          itemCount: buses.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Text(
                                        address.split(",").first.toUpperCase(),
                                        style:
                                            tt(foreground, h2, FontWeight.bold),
                                      )),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Text(
                                        "Buses which go through here",
                                        style: poppins(Colors.grey.shade600, h4,
                                            FontWeight.w600),
                                      )),
                                  InkWell(
                                    onTap: () {
                                      if (markers[MarkerId(
                                              buses[index].toString())] !=
                                          null) {
                                        mapController!.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: markers[MarkerId(
                                                          buses[index]
                                                              .toString())]!
                                                      .position)),
                                        );
                                      } else {
                                        final snackBar = SnackBar(
                                          duration:
                                              const Duration(milliseconds: 350),
                                          content: Text(
                                            'Bus not in service.',
                                            style: poppins(Colors.white, h3,
                                                FontWeight.w600),
                                          ),
                                          backgroundColor: Colors.red,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        box(buses[index].toString()),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            child: Divider(
                                              color: Colors.grey.shade400,
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
                                if (markers[
                                        MarkerId(buses[index].toString())] !=
                                    null) {
                                  mapController!.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: markers[MarkerId(
                                                    buses[index].toString())]!
                                                .position)),
                                  );
                                } else {
                                  final snackBar = SnackBar(
                                    duration: const Duration(milliseconds: 350),
                                    content: Text(
                                      'Bus not in service.',
                                      style: poppins(
                                          Colors.white, h3, FontWeight.w600),
                                    ),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Column(
                                children: [
                                  box(buses[index].toString()),
                                  Container(
                                      margin: const EdgeInsets.only(left: 15),
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
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
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
