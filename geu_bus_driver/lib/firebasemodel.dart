
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geu_bus_driver/data.dart';

class Data {
  late String driverName;
  late num busNo;
  late String phoneNumber;
  late double latitude;
  late double longitude;
  late double total;
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
