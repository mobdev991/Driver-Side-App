import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riorider/Models/rideDetails.dart';
import 'package:riorider/config.dart';
import 'package:riorider/main.dart';
import 'package:riorider/screens/arrived_on_spot_page.dart';
import 'package:riorider/widgets/signup_form.dart';
import '../Assistance/assistanceMethods.dart';

class NotificationDialog extends StatelessWidget {
  final RideDetails rideDetails;

  NotificationDialog(this.rideDetails);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "images/Rio Logo.png",
              width: 120,
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "New Ride Request!",
              style: TextStyle(fontFamily: "Brand-Bold", fontSize: 18),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/mastercard-2.png',
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        rideDetails.pickup_address!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/mastercard-2.png',
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        rideDetails.dropoff_address!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
              color: Colors.black38,
              thickness: 2,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {
                      print("onpressed for cancel is called");
                      assetsAudioPlayer.stop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: TextStyle(fontSize: 14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.red),
                    ),
                    color: Colors.white,
                    textColor: Colors.red,
                    padding: EdgeInsets.all(8),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.green),
                    ),
                    onPressed: () {
                      assetsAudioPlayer.stop();
                      checkAvailabilityOfRide(context);
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      "Accept".toUpperCase(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkAvailabilityOfRide(context) {
    rideRequestRef.once().then((DatabaseEvent event) {
      Navigator.pop(context);
      DataSnapshot snap = event.snapshot;

      String theRideId = "";

      if (snap.exists) {
        theRideId = snap.value.toString();
      } else {
        displayToastMessage("Ride do not exists", context);
      }

      if (theRideId == rideDetails.ride_request_id) {
        rideRequestRef.set("accepted");
        AssistantMethods.disableHometabLiveLocationUpdates();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArrivedPage(rideDetails)));
      } else if (theRideId == 'cancelled') {
        displayToastMessage('Ride Cancelled', context);
      } else if (theRideId == 'timeout') {
        displayToastMessage('Request Timeout', context);
      } else {
        displayToastMessage('Ride Do not Exists', context);
      }
    });
  }
}
