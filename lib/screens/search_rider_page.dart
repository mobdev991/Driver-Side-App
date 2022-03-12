import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../screens/rider_notification_page.dart';

class SearchRider extends StatefulWidget {
  const SearchRider({Key? key}) : super(key: key);

  @override
  _SearchRiderState createState() => _SearchRiderState();
}

class _SearchRiderState extends State<SearchRider> {
  GlobalKey<ScaffoldState> _scaffoldKEY = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController? newGoogleMapControler;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKEY,
      drawer: Drawer(
          child: Container(
        color: Colors.indigo,
        child: ListView(
          children: [
            Container(
                color: Colors.indigo,
                child: DrawerHeader(
                    child: Container(
                  color: Colors.indigo,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          "images/third_pic.jpg",
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Zayd",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  // color: Colors.indigo,
                ))),
            Divider(thickness: 1, color: Colors.white),
            ListTile(
                leading: Icon(Icons.message, color: Colors.white),
                title: Text(
                  "Messages",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>   MyWalet()),

                  //   );
                },
                trailing: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15,
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.indigo),
                  ),
                )),
            Divider(thickness: 1, color: Colors.white),
            ListTile(
              leading:
                  Icon(Icons.monetization_on_outlined, color: Colors.white),
              title: Text(
                "Earnings",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => InviteFriend()));
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.white),
              title: Text(
                "History",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>   SuportPage()),

                // );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.support, color: Colors.white),
              title: Text(
                "Online Support",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      )),
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
                        onPressed: () {
                          _scaffoldKEY.currentState!.openDrawer();
                        },
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
                  height: 135,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(34),
                          topRight: Radius.circular(34)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 16,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100, right: 100),
                          child: Divider(
                            color: Colors.black45,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You\'re Online!',
                              style: TextStyle(color: Colors.indigo),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             RiderNotification()));
                                },
                                child: Text(
                                  'Searching for Rides...',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
