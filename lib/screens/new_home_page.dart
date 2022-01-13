import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 450,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                            ),
                            label: Text(
                              'Back',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Selected Locations',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.directions,
                            color: Colors.indigo,
                          ),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    // color: Colors.grey,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 14),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: const BorderSide(
                                      //       color: Colors.grey, width: 2.0),
                                      //   // borderRadius: BorderRadius.circular(25.0),
                                      // ),
                                      // border: InputBorder.none,
                                      hintText: 'Enter Destination',
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.indigo,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Destination Location'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Suggested Routes',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.grey,
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            child: Text(
                              '20 Min',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.drive_eta,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: Colors.indigo,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Text(
                              'Rs 200',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.grey,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            child: Text(
                              '30 Min',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.drive_eta,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                          Icon(
                            Icons.train,
                            color: Colors.black,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.drive_eta,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Text(
                              'Rs 150',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.grey,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            child: Text(
                              '40 Min',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.drive_eta,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                          Icon(
                            Icons.train,
                            color: Colors.black,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.directions_walk,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Text(
                              'Rs 100',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.grey,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            child: Text(
                              '60 Min',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.directions_walk,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                          Icon(
                            Icons.train,
                            color: Colors.black,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.directions_walk,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Text(
                              'Rs 50',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
