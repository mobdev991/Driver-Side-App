import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../screens/order_cancel.dart';

class FinishRide extends StatefulWidget {
  const FinishRide({Key? key}) : super(key: key);

  @override
  _FinishRideState createState() => _FinishRideState();
}

class _FinishRideState extends State<FinishRide> {
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
                left: 10,
                right: 10,
                child: Container(
                    height: 80,
                    child: Card(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Picking Up Rider',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Pickup location',
                                  style: TextStyle(color: Colors.indigo),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(color: Colors.indigo)),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: Text('05 km',
                                        style: TextStyle(color: Colors.indigo)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )))),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 330,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 120, right: 120),
                        child: Divider(
                          thickness: 3,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Trip Details',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Distance Remaining",
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 25,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                color: Colors.grey[300],
                                onPressed: () {},
                                child: Text(
                                  '2 km',
                                  style: TextStyle(color: Colors.indigo),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Estimated Time Left",
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 25,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                color: Colors.grey[300],
                                onPressed: () {},
                                child: Text(
                                  '3 min',
                                  style: TextStyle(color: Colors.indigo),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/third_pic.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text('Abdullah',
                                    style: TextStyle(
                                      color: Colors.indigo,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "4.5 ",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 130),
                            Column(
                              children: [
                                Text('CASH',
                                    style: TextStyle(
                                      color: Colors.indigo,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('RS 150',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
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
                                      builder: (context) => OrderCancel()));
                            },
                            child: Text(
                              'Finish Ride',
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
