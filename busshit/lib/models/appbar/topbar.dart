import 'package:busshit/designs/design.dart';
import 'package:busshit/models/map/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Topbar extends StatefulWidget {
  const Topbar({Key? key}) : super(key: key);

  @override
  _TopbarState createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:Alignment.bottomCenter,
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left:15,right: 15,top: 10),
            height: 10,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: pink
            ),
          ),
          Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left:15,right: 15,top: 15),
              child: Text("Nearest stop is",style: tt(foreground,h3,FontWeight.w600),)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 15,right: 15),
                  child: Text("15 minutes away",style: poppins(Colors.green,h1,FontWeight.w600),)),
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(right: 15,left: 15),
                decoration: BoxDecoration(
                  color: pink,
                    border: Border.all(color: Colors.grey.shade300,width: 1),
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
                    icon: const Icon(Icons.home),
                    onPressed: (){
                      mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(currentPosition.latitude, currentPosition.longitude),
                            zoom: 18.0,
                          ),
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
              margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
              child: Text("Bus Info".toUpperCase(),style: tt(foreground.withOpacity(0.75),h6,FontWeight.w600),)),
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
                          child: Text("Bus No. 15",style: tt(foreground,h4,FontWeight.w600),),
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
                          child: Text("Salman khan",style: tt(foreground,h4,FontWeight.w600),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
