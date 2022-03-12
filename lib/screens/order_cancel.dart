import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riorider/screens/rider_notification_page.dart';
import 'package:riorider/theme.dart';
import '../screens/total_fare.dart';

class OrderCancel extends StatefulWidget {
  const OrderCancel({Key? key}) : super(key: key);

  @override
  _OrderCancelState createState() => _OrderCancelState();
}

class _OrderCancelState extends State<OrderCancel> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  double notificationContainerHeight = 0;

  bool showNotification = false;

  String btnTitle = "Arrived";
  Color btnColor = Colors.blueAccent;

  GoogleMapController? newGoogleMapControler;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 275,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(34),
                        topRight: Radius.circular(34)),
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
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 120, right: 120),
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      height: 70,
                      // color: Colors.indigo,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.indigo,
                                  radius: 25,
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.indigo,
                                  radius: 25,
                                  child: Icon(
                                    Icons.message,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '5 km',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'rider is waiting',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage('images/third_pic.jpg'),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'rider Name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.indigo,
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              '4.5',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 65, right: 0),
                                    child: Text(
                                      'CASH',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                  Text(
                                    'Rs, 120 - Rs, 150',
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 85, right: 85),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          color: btnColor,
                          onPressed: () async {
                            // if (status == "accepted") {
                            //   status = 'arrived';
                            //   String? rideRequestId =
                            //       widget.rideDetails.ride_request_id;
                            //   newRequestRef
                            //       .child(rideRequestId!)
                            //       .child("status")
                            //       .set(status);
                            //
                            //   setState(() {
                            //     btnTitle = "Start";
                            //     btnColor = Colors.purple;
                            //   });
                            //
                            //   await getPlaceDirection(
                            //       widget.rideDetails.pickup!,
                            //       widget.rideDetails.dropoff!);
                            // } else if (status == "arrived") {
                            //   status = 'onride';
                            //   String? rideRequestId =
                            //       widget.rideDetails.ride_request_id;
                            //   newRequestRef
                            //       .child(rideRequestId!)
                            //       .child("status")
                            //       .set(status);
                            //
                            //   setState(() {
                            //     btnTitle = "End Trip";
                            //     btnColor = Colors.red;
                            //   });
                            //
                            //   initTimer();
                            // } else if (status == 'onride') {
                            //   endTheTrip();
                            // }
                          },
                          child: Text(
                            btnTitle,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(34),
                      topRight: Radius.circular(34),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: Divider(
                          thickness: 3,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.indigo,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Order Canceled",
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Rider has canceled\n the order!",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Reason: Driver was not\n responding",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: 170,
                        child: MaterialButton(
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () {
                            if (showNotification == true) {
                              setState(() {
                                notificationContainerHeight = 350;
                                showNotification = false;
                              });
                            } else {
                              showNotification = true;
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //
                            //         builder: (context) => TotalFare()));
                            print(showNotification);
                          },
                          child: Text("Go Online",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
