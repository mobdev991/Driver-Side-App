import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riorider/screens/login.dart';
import '../screens/arrived_on_spot_page.dart';

class AcceptRide extends StatefulWidget {
  const AcceptRide({Key? key}) : super(key: key);

  @override
  _AcceptRideState createState() => _AcceptRideState();
}

class _AcceptRideState extends State<AcceptRide> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController? newGoogleMapControler;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapControler = controller;
                }),
            Positioned(
                top: 30,
                left: 20,
                child: Container(
                    height: 60,
                    child: Card(
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.indigo,
                        iconSize: 35,
                        onPressed: () {},
                      ),
                    ))),
            Positioned(
                top: 30,
                right: 20,
                child: Container(
                    height: 60,
                    child: Card(
                      child: IconButton(
                        icon: Icon(Icons.notification_add),
                        color: Colors.indigo,
                        iconSize: 35,
                        onPressed: () {},
                      ),
                    ))),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          //spreadRadius: 0.5,
                          //  offset: Offset(0.7, 0.7),
                        ),
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 120, right: 120),
                        child: Divider(
                          thickness: 4,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('New Rider Found',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold)),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Distance',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '60 KM',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Est To PickUp',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '10 M',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rider\'s Current Location',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Islamabad',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rider\'s Destination ',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Lahore',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 54, right: 54),
                      //   child: Column(
                      //     children: [
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Total Distance',
                      //             style: TextStyle(
                      //                 color: Colors.indigo,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           Text(
                      //             'Est to Destination',
                      //             style: TextStyle(
                      //                 color: Colors.indigo,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             '25 Km',
                      //             style: TextStyle(
                      //               color: Colors.indigo,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 100,
                      //           ),
                      //           Text(
                      //             '11:10pm',
                      //             style: TextStyle(
                      //               color: Colors.indigo,
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 54, right: 54),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Estimated Fare',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'RS 500',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 85, right: 85),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            color: Colors.indigo,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()));
                            },
                            child: Text(
                              ' Accept Ride ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
