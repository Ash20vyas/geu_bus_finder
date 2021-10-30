import 'dart:convert';
import 'dart:developer';

import 'package:busshit/designs/design.dart';
import 'package:busshit/models/appbar/topbar.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data.dart';

bool showStatus = true;
GoogleMapController? mapController;
Position currentPosition = Position(latitude:30.270317568668297,longitude: 77.99668594373146,timestamp: DateTime.now(),altitude: 0, speed: 0, accuracy: 1, heading: 0, speedAccuracy: 0,);
var maptype =MapType.normal;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final CameraPosition _initialLocation =  const CameraPosition(
      target: LatLng(30.270317568668297, 77.99668594373146), zoom: 5);

 Set<Marker> markers = {};

 String startCoordinatesString = '(${currentPosition.latitude}, ${currentPosition.longitude})';



  slave() async {
   var l = [];
   for(int i=0;i<stops.length;i++){
     var x = await locationFromAddress(stops[i]);
     var m = {
       '"stop"': '"'+stops[i]+'"',
       '"loc"' : [x[0].latitude , x[0].longitude]
     };
    l.add(m);
   }
   log(l.toString());

 }


 themeLoader() async {
    var style = await rootBundle.loadString("assets/live.json");
    mapController!.setMapStyle(style);
  }
  bool isFuckingLoading = false;
 _getCurrentLocation() async {

   setState(() {
     isFuckingLoading = true;
   });
   Marker startMarker = Marker(
     markerId: MarkerId('(${currentPosition.latitude}, ${currentPosition.longitude})'),
     position: LatLng(currentPosition.latitude,currentPosition.longitude),
     icon:BitmapDescriptor.defaultMarker,
   );
   markers.add(startMarker);



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
   setState(() {
     isFuckingLoading = false;
   });
 }




 @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocation();
    slave();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                    child: GoogleMap(
                      initialCameraPosition: _initialLocation,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: maptype,
                      zoomGesturesEnabled: true,
                      minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                      zoomControlsEnabled: false,
                      markers: markers,
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
                        mapController = controller;
                        themeLoader();
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin:const EdgeInsets.only(right: 15,top:20),
                      alignment: Alignment.topRight,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        color:pink.withOpacity(0.75),
                        border:Border.all(color: Colors.grey.shade400,width: 0.5),
                        boxShadow: [
                          BoxShadow(
                            color: maptype == MapType.satellite ? Colors.grey.shade800: Colors.grey.shade200,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
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
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),


              animationCurveExpand: Curves.bounceOut,
              animationCurveContract: Curves.bounceIn,
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
                              "1234567890",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.bottomLeft,
                            margin:
                            const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                            child: Text(
                              "30 Minutes",
                              style: tt(
                                  darkBlue, h2, FontWeight.w600),
                            )),
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(right: 15,left: 15),
                          decoration: BoxDecoration(
                              color: darkBlue,
                              border: Border.all(color: Colors.grey.shade700,width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius:BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.home,color: pink,),
                              onPressed: (){
                                mapController!.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    _initialLocation
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
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
                      busNumber: "Bus no. 12",
                    ),
                    OtherBuses(number: 2, busNumber: "Bus no. 6"),
                    OtherBuses(
                      number: 3,
                      busNumber: "Bus no. 19",
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
