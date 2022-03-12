import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../screens/accept_ride_page.dart';

class RiderNotification extends StatelessWidget {
  RiderNotification({Key? key, required this.containerHeight})
      : super(key: key);

  double containerHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: containerHeight,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34), topRight: Radius.circular(34)),
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
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'New Order',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white38,
                        onPressed: () {},
                        child: Text(
                          '3 min',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
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
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 30,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white38,
                        onPressed: () {},
                        child: Text(
                          'RS 20',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              Container(
                height: 70,
                // color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 28),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 7,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 5,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Pickup location ',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
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
                            width: 14,
                          ),
                          Text(
                            'Dropoff location ',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('images/third_pic.jpg'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Abdullah',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                            Text(
                              '03031200099',
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
                        Row(
                          children: [
                            Icon(
                              Icons.call_sharp,
                              color: Colors.indigo,
                              size: 50,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.message_rounded,
                              color: Colors.indigo,
                              size: 50,
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
                    color: Colors.indigo,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcceptRide()));
                    },
                    child: Text(
                      'Accept Ride',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
