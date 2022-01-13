import 'package:flutter/cupertino.dart';
import 'package:riorider/Models/address.dart';
import '../Assistance/assistanceMethods.dart';

class AppData with ChangeNotifier {
  Address? pickUpLocation, dropOffLocation;

  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
  // late Address pickUpLocation;
  //
  // void updatePickUpLocationAddress(Address pickUpAddress) {
  //   pickUpLocation = pickUpAddress;
  //   notifyListeners();
  // }
}
