import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riorider/Assistance/assistanceMethods.dart';
import 'package:riorider/Models/drivers.dart';
import 'package:riorider/Notifications/notification_dialog.dart';
import 'package:riorider/Notifications/pushNotificationService.dart';
import 'package:riorider/config.dart';
import 'package:riorider/main.dart';
import 'package:riorider/providers/appData.dart';
import 'package:riorider/screens/accept_ride_page.dart';
import 'package:riorider/screens/login.dart';
import '../Models/direactionDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKEY = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  PushNotificationService pushee = PushNotificationService();

  DirectionDetails? tripDirectionDetails;

  var geoLocator = Geolocator();

  String driverStatusText = "Offline";
  Color driverStatusColor = Colors.black12;
  bool isDriverAvailable = false;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double bottomPaddingMap = 100;

  double maindialogContainerHeight = 0;

  DatabaseReference? rideRequestRef;
  String notificationMsg = 'Waiting for Notifications';

  @override
  void initState() {
    print("initstate-------------------------------in");
    super.initState();
    getCurrentDriverInfo();
    AssistantMethods.getCurrentOnLineUserInfo();
    print("initstate-------------------------------out");
  }

  // void locatePosition() async {
  //   Position position =
  //       Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }

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
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: bottomPaddingMap),
              child: GoogleMap(
                  //padding: EdgeInsets.only(bottom: 500),
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  polylines: polylineSet,
                  markers: markersSet,
                  circles: circlesSet,
                  onMapCreated: (GoogleMapController controller) {
                    _controllerGoogleMap.complete(controller);
                    newGoogleMapControler = controller;
                    getCurrentLocation();
                  }),
            ),
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
                        onPressed: () {
                          // pushee.retrieveRideRequestInfo(
                          //     '-MtHF3I71uB47gV0IuGN', context);
                        },
                      ),
                    ))),
            Positioned(
                top: 350,
                right: 20,
                child: Container(
                    height: 60,
                    child: Card(
                      child: IconButton(
                        icon: Icon(Icons.my_location),
                        color: Colors.indigo,
                        iconSize: 35,
                        onPressed: () {
                          getCurrentLocation();
                        },
                      ),
                    ))),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 225,
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
                          padding: const EdgeInsets.only(left: 70, right: 70),
                          child: Divider(
                            color: Colors.black45,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              color: Colors.white,
                              child: GestureDetector(
                                onTap: () {
                                  print("go clicked");

                                  if (isDriverAvailable != true) {
                                    makeDriverOnlineNow();
                                    getLocationLiveUpdates();

                                    setState(() {
                                      driverStatusColor = Colors.green;
                                      driverStatusText = "Online";
                                      isDriverAvailable = true;
                                    });

                                    print(
                                        'your are online-----------------------------------------');
                                  } else {
                                    setState(() {
                                      driverStatusColor = Colors.black38;
                                      driverStatusText = "Offline Now";
                                      isDriverAvailable = false;
                                    });
                                    makeDriverOfflineNow();
                                  }
                                },
                                child: CircleAvatar(
                                  foregroundColor: driverStatusColor,
                                  radius: 70,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.arrow_upward_sharp,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        driverStatusText,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {});
  }

  void getCurrentLocation() async {
    print('GetCurrent Lcoation executed');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    // currentPosition = position;

    print('GetCurrent  executed');
    LatLng currentPosition = LatLng(position.latitude, position.longitude);
    print('GetCurrent Lcoation ');
    CameraPosition cameraPositionuser =
        new CameraPosition(target: currentPosition, zoom: 14);

    newGoogleMapControler!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPositionuser!));
    String address =
        await AssistantMethods().searchCoordinateAddress(position, context);

    print('your address yo bellow' ' :: ${address}');

    print("currentFirebaseUser 00000000000000000000000000000000");
    print(currentFirebaseUser);
    print("currentFirebaseUser 00000000000000000000000000000000");
  }

  Future<void> getPlaceDirection() async {
    print("getplacedirections executed");
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLapLng = LatLng(initialPos!.latitude, initialPos.longitude);
    var dropOffLapLng = LatLng(finalPos!.latitude, finalPos.longitude);
    print("getsinitial values");

    var details = await AssistantMethods.obtainDirectionDetails(
        pickUpLapLng, dropOffLapLng);

    setState(() {
      tripDirectionDetails = details;
    });

    print('this is encoded point');
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();
    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
          color: Colors.lightBlueAccent,
          polylineId: PolylineId("PolylineID"),
          jointType: JointType.round,
          points: pLineCoordinates,
          width: 4,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);

      polylineSet.add(polyline);
    });

    LatLngBounds latLngBounds;

    if (pickUpLapLng.latitude > dropOffLapLng.latitude &&
        pickUpLapLng.longitude > dropOffLapLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLapLng, northeast: pickUpLapLng);
    } else if (pickUpLapLng.longitude > dropOffLapLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLapLng.latitude, dropOffLapLng.longitude),
          northeast: LatLng(dropOffLapLng.latitude, pickUpLapLng.longitude));
    } else if (pickUpLapLng.latitude > dropOffLapLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLapLng.latitude, pickUpLapLng.longitude),
          northeast: LatLng(pickUpLapLng.latitude, dropOffLapLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLapLng, northeast: dropOffLapLng);
    }

    newGoogleMapControler!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow:
          InfoWindow(title: initialPos.placeName, snippet: "Current Location"),
      position: pickUpLapLng,
      markerId: MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: finalPos.placeName, snippet: "Destination"),
      position: dropOffLapLng,
      markerId: MarkerId("dropOffId"),
    );

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      circleId: CircleId("pickUpId"),
      fillColor: Colors.white,
      center: pickUpLapLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.yellowAccent,
    );

    Circle dropOffLocCircle = Circle(
      circleId: CircleId("dropOffId"),
      fillColor: Colors.white,
      center: dropOffLapLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.yellowAccent,
    );

    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
  }

  void makeDriverOnlineNow() async {
    rideRequestRef = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("newRide");

    print('rideRequest Reference value =   ${rideRequestRef!.key}');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    currentPosition = position;

    print("inside makeDriverOnlineNow-----------------------------------");
    currentFirebaseUser = firebaseUser;
    print(currentFirebaseUser);
    Geofire.initialize("availableDrivers");
    Geofire.setLocation(firebaseUser!.uid, currentPosition!.latitude,
        currentPosition!.longitude);
    rideRequestRef!.set('searching');
    rideRequestRef!.onValue.listen((event) {});
  }

  void getLocationLiveUpdates() {
    homeTabPageStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;

      if (isDriverAvailable == true) {
        Geofire.setLocation(
            currentFirebaseUser!.uid, position.latitude, position.longitude);
      }

      LatLng latlang = LatLng(position.latitude, position.longitude);
      newGoogleMapControler!.animateCamera(CameraUpdate.newLatLng(latlang));
    });
  }

  void makeDriverOfflineNow() {
    Geofire.removeLocation(currentFirebaseUser!.uid);
    rideRequestRef!.onDisconnect();
    rideRequestRef!.remove();
    print('your are offline-----------------------------------------');
  }

  void getCurrentDriverInfo() async {
    print("getCurrentDriverInfo Executed -----------------------------------");

    currentFirebaseUser = await FirebaseAuth.instance.currentUser;

    driverRef
        .child(currentFirebaseUser!.uid)
        .once()
        .then((DatabaseEvent event) {
      print("datasnap value in makedriver online");
      DataSnapshot snap = event.snapshot;
      print(snap.value);
      if (snap.exists) {
        driversInformation = Drivers.fromSnapshot(snap);
      }
    });

    PushNotificationService pushNotificationService = PushNotificationService();

    pushNotificationService.initialize();
    pushNotificationService.getToken();
  }
}
