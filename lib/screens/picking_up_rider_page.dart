import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickUpRider extends StatefulWidget {
  const PickUpRider({Key? key}) : super(key: key);

  @override
  _PickUpRiderState createState() => _PickUpRiderState();
}

class _PickUpRiderState extends State<PickUpRider> {
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
            // Positioned(
            //     top: 30,
            //     right: 20,
            //     child: Container(
            //         height: 60,
            //         child: Card(
            //           child: IconButton(
            //             icon: Icon(Icons.notification_add),
            //             color: Colors.indigo,
            //             iconSize: 35,
            //             onPressed: () {},
            //           ),
            //         ))),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 115,
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
                                    width: 70,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '2 mins away',
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
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
