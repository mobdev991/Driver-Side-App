import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riorider/Models/drivers.dart';
import 'package:riorider/Models/rideDetails.dart';
import 'package:riorider/config.dart';
import 'package:riorider/main.dart';
import 'package:riorider/screens/arrived_on_spot_page.dart';
import 'package:riorider/widgets/signup_form.dart';
import 'package:url_launcher/url_launcher.dart';
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
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 16,
                //spreadRadius: 0.5,
                //  offset: Offset(0.7, 0.7),
              ),
            ]),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    (languageEnglish == false)?' New Ride Request ' : ' نئی سواری کی درخواست ',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white38,
                        onPressed: () {},
                        child: Text(
                          '2 km',
                          style: TextStyle(
                              color: Colors.indigo, fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white38,
                        onPressed: () {},
                        child: Text(
                          'RS 250',
                          style: TextStyle(
                              color: Colors.indigo, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Divider(
              thickness: 5,
              color: Colors.black26,
            ),
            Container(
              height: 60,
              // color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.indigo,
                          radius: 6,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          rideDetails.pickup_address!,
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.indigo,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          rideDetails.dropoff_address!,
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 5,
              color: Colors.black26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('images/third_pic.jpg'),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rideDetails.rider_name!,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      rideDetails.rider_phone!,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),

            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 150,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.indigo,
                      onPressed: () {
                        print("onpressed for accepted is called.......................................................");

                        rideDetailsGlobal = rideDetails;
                        rideRequestIDGlobal = rideDetails.ride_request_id;
                        // assetsAudioPlayer.stop();
                        checkAvailabilityOfRide(context);
                      },
                      child: Text(
                          (languageEnglish == false)?' Accept Ride ' : ' سواری کو قبول کریں ',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      rideDetailsGlobal = rideDetails;
                      // setRideStatusToCancel();
                      print("onpressed for cancel is called");
                      DatabaseReference newRideRef = driverRef.child(currentFirebaseUser!.uid).child('newRide');
                      print('Driver Status Ride');
                      print(newRideRef.key);
                      newRideRef.set('searching');
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 45,
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
  void setRideStatusToCancel(){
    DatabaseReference newRideRef = driverRef.child(currentFirebaseUser!.uid).child('newRide');
    print('Ride');
    print(newRideRef.key);
    newRideRef.set('canceled');
  }
  void setRideStatusToAccepted(){
    DatabaseReference newRideRef = driverRef.child(currentFirebaseUser!.uid).child('newRide');
    print('Driver Status Ride');
    print(newRideRef.key);
    newRideRef.set('accepted');

    // DatabaseReference rideStatus = rideRequestRef.child(rideDetails.ride_request_id!).child("status");
    // print('RideStatus');
    // print(rideStatus.key);
    // rideStatus.set('accepte');
  }

  void checkAvailabilityOfRide(context) {

    print('inside check availabilityof ride');
    newRequestRef.child(rideDetails.ride_request_id!).once().then((DatabaseEvent event) {
      Navigator.pop(context);
      print('rideRequestRef ::');
      print(newRequestRef.key);

      DataSnapshot snap = event.snapshot;

      print(snap.value);

      String theRideId = "";

      if (snap.exists) {
        theRideId = newRequestRef.child(rideDetails.ride_request_id!).key.toString();
        print(' Ride ID :: ');
        print(theRideId);
      } else {
        print('Ride ID doesnot exists');
        displayToastMessage("Ride do not exists", context);
      }
      print('rideDetails ride request id');
      print(rideDetails.ride_request_id);

      if (theRideId == rideDetails.ride_request_id) {

        AssistantMethods.disableHometabLiveLocationUpdates();
        setRideStatusToAccepted();
        newRequestRef.child(rideDetails.ride_request_id!).child('status').set('accepted');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArrivedPage(rideDetails)));
      } else if (theRideId == 'cancelled') {
        displayToastMessage('Ride Cancelled', context);
      } else if (theRideId == 'timeout') {
        displayToastMessage('Request Timeout', context);
      } else {


        displayToastMessage('Ride Do not Existsss', context);

      }
    });
  }
}
