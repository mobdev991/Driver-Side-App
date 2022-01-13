import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riorider/Assistance/requestAssistant.dart';
import 'package:riorider/Models/address.dart';
import 'package:provider/provider.dart';
import 'package:riorider/Models/direactionDetails.dart';
import 'package:riorider/config.dart';
import 'package:riorider/providers/appData.dart';
import '../Models/allUsers.dart';

class AssistantMethods {
  Future<String> searchCoordinateAddress(Position position, context) async {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyDPyy_OhpKP5Zv5aMWjmtBDE7ErnrRu_bc";

    var response = await RequestAssistant.getRequest(url);

    if (response != "failed") {
      // placeAddress = response["results"][0]["formatted_address"];

      st1 = response["results"][0]["address_components"][3]["long_name"];
      st2 = response["results"][0]["address_components"][4]["long_name"];
      // st3 = response["results"][0]["address_components"][5]["long_name"];
      // st4 = response["results"][0]["address_components"][6]["long_name"];

      placeAddress = st1 + st2;

      Address userPickUpAddress = new Address(
          placeAddress, placeAddress, position.latitude, position.longitude);

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }

    return placeAddress;
  }

  static Future<DirectionDetails> obtainDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    print("printing initial pos ${initialPosition}");
    print("printing initial pos ${finalPosition}");

    String directionUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=AIzaSyDPyy_OhpKP5Zv5aMWjmtBDE7ErnrRu_bc';
    var res = await RequestAssistant.getRequest(directionUrl);

    print('res on assistanceMethod called');
    print(res);
    // if (res == "failed") {
    //   return "";
    // }
    DirectionDetails directionDetails = DirectionDetails(
        distanceValue: res["routes"][0]["legs"][0]["distance"]["value"],
        durationValue: res["routes"][0]["legs"][0]["duration"]["value"],
        distanceText: res["routes"][0]["legs"][0]["distance"]["text"],
        durationText: res["routes"][0]["legs"][0]["duration"]["text"],
        encodedPoints: res["routes"][0]["overview_polyline"]["points"]);

    print('printing direction details');
    print(directionDetails);
    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    double totalFareAmount = (directionDetails.distanceValue / 1000) * 50;
    return totalFareAmount.truncate();
  }

  static void getCurrentOnLineUserInfo() async {
    firebaseUser = await FirebaseAuth.instance.currentUser;
    String userId = firebaseUser!.uid;

    DatabaseReference reference =
        await FirebaseDatabase.instance.ref().child("drivers").child(userId);

    DatabaseEvent event = await reference.once();

    DataSnapshot snap = event.snapshot;

    print(
        "--------------------------------------------------------------------------- /n \n "
        "getcurrentonlineUSerINfo");

    print(reference.parent);
    print(reference.path);

    print("00000000000000");

    print(reference.key);
    print(snap.value);

    if (snap.exists) {
      userCurrentInfo = Users.fromSnapshot(snap);
      print("user current info printing----------------");
      print(userCurrentInfo!.phone);
      print(userCurrentInfo);
    }

    // reference.once().then((event). {
    //   final dataSnapshot = event.snapshot;
    //   if (dataSnapshot!.value != null) {
    //     userCurrentInfo = Users.fromSnapshot(dataSnapshot);
    //   }
    // });
    // reference.once().then((dataSnapShot) {
    //   DataSnapshot dataSnapshot = "" as DataSnapshot;
    //
    //   if (dataSnapShot.snapshot.value != null) {
    //     userCurrentInfo = Users.fromSnapshot(dataSnapshot);
    //   }
    // });
  }

  static void disableHometabLiveLocationUpdates() {
    homeTabPageStreamSubscription!.pause();
    Geofire.removeLocation(currentFirebaseUser!.uid);
  }

  static void enableHomeTabLiveLocationUpdate() {
    homeTabPageStreamSubscription!.resume();
    Geofire.setLocation(currentFirebaseUser!.uid, currentPosition!.latitude,
        currentPosition!.longitude);
  }
}
