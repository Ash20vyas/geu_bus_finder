import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geu_bus_driver/homepage.dart';

class Data {
  late String driverName;
  late num busNo;
  late String phoneNumber;
  late double latitude;
  late double longitude;
  late bool clearedLogs;
  //data goes to cloud in the form of map. so creating a map before is a efficient process
  createMap() {
    return {
      "driverName": driverName,
      "busNo": busNo,
      "Log": log,
      "phoneNumber": phoneNumber,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}

class FirebaseModal {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  bool updateData(Data data) {
    if (clearedLogs == false) {
      slave() async {
        var collection = instance.collection("root").doc(data.busNo.toString()).collection("userLocation");
        var snapshots = await collection.get();
        for (var doc in snapshots.docs) {
          await doc.reference.delete();
        }
        clearedLogs = true;
      }

      slave();
    }

    //check our data object has all values before it goes to cloud.
    if (data.driverName == null || data.busNo == null || data.phoneNumber == null) {
      return false;
    } else {
      instance.collection("root").doc(data.busNo.toString()).set(data.createMap());
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
