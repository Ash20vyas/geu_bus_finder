import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  late String driverName;
  late num busNo;
  late String phoneNumber;
  //data goes to cloud in the form of map. so creating a map before is a efficient process
  createMap() {
    return {
      "driverName": driverName,
      "busNo": busNo,
      "phoneNumber": phoneNumber,
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
}
