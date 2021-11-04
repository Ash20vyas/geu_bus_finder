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
      height: 130,
      margin: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 3,
            blurRadius: 6,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left:15,right: 15,top: 10),
            height: 10,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
                  child: Text(activeBuses[0].time.toString().split(".").first   + " minutes away",style: poppins(Colors.green,h2,FontWeight.w600),)),
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: pink,
                    border: Border.all(color: Colors.grey.shade300,width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  borderRadius:BorderRadius.circular(5)
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.home,size: 20,),
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

        ],
      ),
    );
  }
}
