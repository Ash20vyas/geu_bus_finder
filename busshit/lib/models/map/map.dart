import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:busshit/designs/design.dart';
import 'package:busshit/models/appbar/topbar.dart';
import 'package:busshit/models/bus/busmodel.dart';
import 'package:busshit/models/bus/firebasemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data.dart';

bool showStatus = true;
var busicon;
var university;
var busstop;

GoogleMapController? mapController;
Position collegePosition = Position(latitude:30.270317568668297,longitude: 77.99668594373146,timestamp: DateTime.now(),altitude: 0, speed: 0, accuracy: 1, heading: 0, speedAccuracy: 0,);
var currentPosition;
var maptype =MapType.normal;
var activeBuses = List<dynamic>.generate(10,(i)=> null);





class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final CameraPosition _initialLocation =  const CameraPosition(
      target: LatLng(30.270317568668297, 77.99668594373146), zoom: 5);

 final markers = <MarkerId, Marker>{};
 final stopsMarker = <MarkerId, Marker>{};

  void stopPlotter(){
    for(int i = 0; i < locations.length ; i++){
      var map = locations[i];
      Stop stop = Stop();
      stop.objectFromMap(map);
      markers[MarkerId(stop.address)] =  stop.createmarker(context);
    }
  }


 themeLoader() async {
    var style = await rootBundle.loadString("assets/live.json");
    mapController!.setMapStyle(style);
  }
 bool isFuckingLoading = false;

 _getCurrentLocation() async {
      //loading screen on
       setState(() {
         isFuckingLoading = true;
       });
       await BitmapDescriptor.fromAssetImage(
           ImageConfiguration(size: Size(16, 16)), 'assets/bus.png')
           .then((onValue) {
         busicon = onValue;
       });
      await BitmapDescriptor.fromAssetImage(
           ImageConfiguration(size: Size(48, 48)), 'assets/uni.png')
           .then((onValue) {
         university = onValue;
       });
        await BitmapDescriptor.fromAssetImage(
           ImageConfiguration(size: Size(48, 48)), 'assets/bus-stop.png')
           .then((onValue) {
         busstop = onValue;
       });
      
       Marker startMarker = RippleMarker(
         markerId: MarkerId('(${collegePosition.latitude}, ${collegePosition.longitude})'),
         position: LatLng(collegePosition.latitude,collegePosition.longitude),
         icon:university,
         ripple: false
       );
       markers[MarkerId('(${collegePosition.latitude}, ${collegePosition.longitude})')] = startMarker;
       var serviceEnabled = await Geolocator.isLocationServiceEnabled();
       var permission = await Geolocator.checkPermission();
       await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
           .then((Position position) async {
         setState(() {
           currentPosition = position;
           print('CURRENT POS: $currentPosition');
         });
       }).catchError((e) {
         print(e);
       });
       stopPlotter();
       FirebaseFirestore.instance.collection('root').snapshots()
           .listen((QuerySnapshot querySnapshot) async {

             for(int i=0;i<querySnapshot.docs.length;i++){
               var document = querySnapshot.docs[i];
               Data d = Data();
               d.phoneNumber = document['phoneNumber'];
               d.busNo = document['busNo'];
               d.driverName = document['driverName'];
               d.latitude = document['latitude'];
               d.longitude = document['longitude'];
               List<Placemark> placemarks = await placemarkFromCoordinates(d.latitude, d.longitude);
               d.areaName = placemarks[0].subLocality;
               double _coordinateDistance(lat1, lon1, lat2, lon2) {
                 var p = 0.017453292519943295;
                 var c = cos;
                 var a = 0.5 -
                     c((lat2 - lat1) * p) / 2 +
                     c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
                 return 12742 * asin(sqrt(a));
               }
               var distance = _coordinateDistance(d.latitude, d.longitude, currentPosition.latitude, currentPosition.longitude);
               var dist2 = _coordinateDistance(d.latitude,d.longitude, collegePosition.latitude, collegePosition.longitude);
               d.time = (distance/25)*60;
               d.collegeReachTime = d.time!.toDouble() + (((dist2)/25) * 60);
               activeBuses[i] = d;
               setState(() {
                 markers[d.marker] = d.createmarker(context) ;
               });
             }
             setState(() {
               isFuckingLoading = false;
             });
       }
       );

 }




 @override
  void initState() {
    // TODO: implement initState
   _getCurrentLocation();
    super.initState();
  }

  var searched = [];

 final controller = Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: pink,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: isFuckingLoading? Center(child: const CircularProgressIndicator()):Stack(
          children: [
            ExpandableBottomSheet(
              background: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Animarker(
                      useRotation : false,
                      rippleRadius: 0.5,  //[0,1.0] range, how big is the circle
                      rippleColor: darkBlue, // Color of fade ripple circle
                      rippleDuration: Duration(milliseconds: 2500),
                      curve: Curves.ease,
                      mapId: controller.future.then<int>((value) => value.mapId), //Grab Google Map Id
                      markers: markers.values.toSet(),
                      child: GoogleMap(
                        initialCameraPosition: _initialLocation,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        mapType: maptype,
                        zoomGesturesEnabled: true,
                        minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                        zoomControlsEnabled: false,
                        onCameraMove: (_) {
                          setState(() {
                            showStatus = false;
                          });
                        },
                        onCameraIdle: () {
                          setState(() {
                            showStatus = true;
                          });
                        },
                        onMapCreated: (GoogleMapController controller) {
                          this.controller.complete(controller);
                          mapController = controller;
                          themeLoader();
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin:const EdgeInsets.only(right: 15,top:80),
                      alignment: Alignment.topRight,
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        color:Colors.white,
                        border:Border.all(color: Colors.grey.shade400,width: 0.5),
                        boxShadow: [
                          BoxShadow(
                            color: maptype == MapType.satellite ? Colors.grey.shade800: Colors.grey.shade300,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.satellite,size: 30,),
                            onPressed: (){
                              if(maptype == MapType.normal){
                                setState(() {
                                  maptype = MapType.satellite;
                                });

                              }
                              else{
                                setState(() {
                                  maptype = MapType.normal;
                                });

                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.book,size: 30,),
                            onPressed: (){
                              mapController!.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    _initialLocation
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.only(left:15,right: 15,top: 1,bottom: 1),
                        margin: EdgeInsets.only(left:15,right: 15,top: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400),
                          boxShadow: [
                            BoxShadow(
                              color: maptype == MapType.satellite ? Colors.grey.shade800: Colors.grey.shade300,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: TextField(
                            onChanged: (val){
                              if(val.length > 0){
                                var temp = [];
                                for(int i = 0; i<activeBuses.length;i++){
                                  var bus = activeBuses[i];
                                  if(bus != null && bus.busNo.toString().contains(val)){
                                    print("===================IN LOOOP=====================");
                                    temp.add(bus);
                                  }
                                }
                                print(searched.length);
                                setState(() {
                                  searched = temp;
                                });
                              }
                              else{
                                setState(() {
                                  searched = [];
                                });

                              }


                            },
                            style:poppins(Colors.grey.shade700,h3,FontWeight.w500) ,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                              hintText: 'Search for stops,Buses',
                              hintStyle: poppins(Colors.grey.shade400,h4,FontWeight.w500)
                            ),
                          ),
                        ),
                      ),
                      AnimatedSwitcher(duration: Duration(milliseconds: 350),
                      child: searched.isNotEmpty? Container(
                        height: 300,
                        margin: EdgeInsets.only(left:15,right: 15,top: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: maptype == MapType.satellite ? Colors.grey.shade800: Colors.grey.shade300,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListView.builder(
                            itemCount: searched.length,
                            itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){

                                  var x = CameraPosition(
                                      target: LatLng(searched[index].latitude,searched[index].longitude), zoom: 14);
                                  mapController!.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        x
                                    ),
                                  );
                                  searched = [];

                                },
                                child: Column(
                                  children: [
                                    Container(
                                      alignment:Alignment.centerLeft,
                                        margin: EdgeInsets.only(left:15,right:15,top: 10),
                                        child: Text("Bus No. " + searched[index].busNo.toString(),style: tt(darkBlue,h3,FontWeight.bold),)),
                                    Row(
                                      children: [
                                        Container(
                                            alignment:Alignment.centerLeft,
                                            margin: EdgeInsets.only(left:15,right:15),
                                            child: Text(searched[index].areaName.toString() ,style: poppins(Colors.grey.shade700,h4,FontWeight.w500),)),

                                        Container(
                                            alignment:Alignment.centerLeft,
                                            margin: EdgeInsets.only(left:15,right:15),
                                            child: Text(searched[index].time.toString().split(".").first +" Minutes Away",style: poppins(Colors.grey.shade700,h4,FontWeight.w500),)),
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left:15),
                                        child: Divider(color: Colors.grey.shade600,thickness: 0.5,))

                                  ],
                                ),
                              );

                        }),
                      ):Container(height: 10,) ,
                      
                      
                      )
                     
                    ],
                  )
                ],
              ),


              animationCurveExpand: Curves.bounceOut,
              animationCurveContract: Curves.ease,
              persistentHeader: const Topbar(),
              expandableContent: Container(
                height: 400,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(right: 15, left: 15,bottom:12.5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
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
                              activeBuses[0].phoneNumber.toString(),
                              style: tt(foreground, h4, FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 0.5,color: Colors.grey.shade400,),
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin:
                        const EdgeInsets.only(left: 15, right: 15, top: 12.5),
                        child: Text(
                          "You will reach college in",
                          style: tt(
                              foreground, h4, FontWeight.w600),
                        )),
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                        child: Text(
                          activeBuses[0].collegeReachTime.toString().split(".").first + " Minutes",
                          style: tt(
                              darkBlue, h2, FontWeight.w600),
                        )),
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Text(
                          "Other nearby buses".toUpperCase(),
                          style: tt(
                              foreground.withOpacity(0.5), h6, FontWeight.w600),
                        )),
                    OtherBuses(
                      number: 1,
                      busNumber: activeBuses[1] ?? "No Bus Found",
                    ),
                    OtherBuses(number: 2, busNumber: activeBuses[2]  ?? "No Bus Found"),
                    OtherBuses(
                      number: 3,
                      busNumber: activeBuses[2] ?? "No Bus Found",
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OtherBuses extends StatelessWidget {
  int number;
  String busNumber;
  OtherBuses({required this.number,required this.busNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin:const EdgeInsets.only(left:15,right:15,top: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(

                      margin: const EdgeInsets.only(left: 30, top: 5),
                      child: Text(number.toString(),
                          style: tt(foreground, h1 + 4, FontWeight.w700)))),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(right: 15, top: 5),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          alignment: Alignment.topLeft,
                          child: Text(busNumber,
                              style: tt(foreground, h3, FontWeight.w500))),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade400,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
