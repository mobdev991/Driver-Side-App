import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riorider/Models/rideDetails.dart';
import 'package:riorider/screens/Home_page.dart';
import 'package:riorider/screens/arrived_on_spot_page.dart';
import '../config.dart';
import '../main.dart';
import '../screens/total_fare_amount.dart';
import 'Home_page.dart';

class TotalFare extends StatefulWidget {
  const TotalFare({
    Key? key,
  }) : super(key: key);

  @override
  _TotalFareState createState() => _TotalFareState();
}

class _TotalFareState extends State<TotalFare> {
  RideDetails rideDetails = RideDetails();
  String fareAmountText = 'RS 0.00';

  double totalFare = 0;
  var rideRequestId = RideDetails().ride_request_id;


  void gettingTotalFare() async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child('Ride Requests')
        .child(rideRequestIDGlobal!)
        .child('fares');

    reference.once().then((DatabaseEvent event) {
      DataSnapshot snap = event.snapshot;

      print("snap SHot Exists or not = ${snap.exists}");

      if (snap.exists) {
        totalFare = double.parse(snap.value.toString());
        setState(() {
          fareAmountText = 'RS ${totalFare}';
        });
      } else {
        print("Issue With Finding Fare Details");
      }
      print(fareAmountText + '1');
    });

    print(fareAmountText);
  }

  @override
  void initState() {
    gettingTotalFare();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 75,
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.indigo),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        (languageEnglish == false)?' Total Fare Amount ' : ' کرایہ کی کل رقم ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        fareAmountText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                Text(
                  (languageEnglish == false)?' receive cash by hand! ' : ' ہاتھ سے نقد وصول کریں! ',
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 190,
                  child: MaterialButton(
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    onPressed: () {

                      DatabaseReference newRideRef = driverRef.child(currentFirebaseUser!.uid).child('newRide');
                      print('Ride');
                      print(newRideRef.key);
                      newRideRef.set('offline');



                      rideRequestIDGlobal = null;
                      rideDetailsGlobal = null;
                      onlineOrOffline = 'online';
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                        (languageEnglish == false)?' Fare Received ' : ' کرایہ وصول ہوا ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
