import 'package:flutter/cupertino.dart';
import 'package:riorider/Models/address.dart';
import 'package:riorider/Models/history.dart';
import '../Assistance/assistanceMethods.dart';

class AppData with ChangeNotifier {
  Address? pickUpLocation, dropOffLocation;

  String earnings = "0";
  int numberOfTrips = 0;
  String newRideStatus = ' ';
  List<String> tripHistoryKeys = [];
  List<History> tripHistoryDataList = [];

  void updateRideStatus(String updateStatus){
    print('new Ride Status in AppData');
    newRideStatus = updateStatus;
    print(newRideStatus);
    notifyListeners();
  }

  void updateEarnings(String updatedEarnings) {
    print('earnings in AppData');
    earnings = updatedEarnings;
    print(earnings);
    notifyListeners();
  }

  void updateNumberOfTrips(int updatedNumberOfTrips) {
    print('earnings in AppData');
    numberOfTrips = updatedNumberOfTrips;
    print('Number Of Trips in Appdata');
    print(numberOfTrips);
    notifyListeners();
  }

  void updateTripKeys(List<String> newKeys) {
    tripHistoryKeys = newKeys;
    notifyListeners();
  }

  void updateTripHistoryData(History eachHistory) {
    tripHistoryDataList.add(eachHistory);
    notifyListeners();
  }

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
