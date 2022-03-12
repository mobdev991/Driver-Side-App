import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:riorider/Assistance/assistanceMethods.dart';
import 'package:riorider/Assistance/mapKitAssistant.dart';
import 'package:riorider/Models/direactionDetails.dart';
import 'package:riorider/Models/rideDetails.dart';
import 'package:riorider/config.dart';
import 'package:riorider/main.dart';
import 'package:riorider/providers/appData.dart';
import 'package:riorider/screens/total_fare.dart';
import 'package:riorider/widgets/collect_fare_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Notifications/pushNotificationService.dart';
import '../chat_packages/chat_home.dart';
import '../screens/picking_up_rider_page.dart';
import '../Assistance/mapKitAssistant.dart';
import '../Assistance/assistanceMethods.dart';

class ArrivedPage extends StatefulWidget {
  final RideDetails rideDetails;

  ArrivedPage(this.rideDetails);

  @override
  _ArrivedPageState createState() => _ArrivedPageState();
}

class _ArrivedPageState extends State<ArrivedPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController? newRideGoogleMapControler;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // Ui Switches to switch positional widgests.. declarations

  double arrivedOnSpotContainerHeight = 270;
  double tripInformationContainerHeight = 0;
  double tripProgressContainerHeight = 0;
  double endTripConfirmationContainerHeight = 0;

  Set<Marker> markerSet = Set<Marker>();
  Set<Circle> circleSet = Set<Circle>();
  Set<Polyline> polyLineSet = Set<Polyline>();

  List<LatLng> polylinesCordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  Position? myPosition;

  double mapPaddingFromBottom = 0;
  var geoLocator = Geolocator();
  // var locationOptions = Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.bestForNavigation) as Position;
  BitmapDescriptor? animatingMarkerIcon;

  String status = 'accepted';
  String? durationRide = "";
  String? distanceRide = "";
  String? fareRide = "";

  bool isRequestingDirection = false;

  String btnTitle = (languageEnglish == false)?' Arrived On Spot ' : ' موقع پر پہنچ گئے ';
  Color btnColor = Colors.blueAccent;



  Timer? timer;
  int durationCounter = 0;


  @override
  void initState() {
    super.initState();
    acceptRideRequest();
  }

  void createIconMarker() {
    if (animatingMarkerIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(1, 1));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "images/tuktukOnMap.png")
          .then((value) {
        animatingMarkerIcon = value;
        print(
            "icon assigned ---------------------------------------------------");
      });
    }
  }

  void getRideLocationUpdated() {
    print("getRideLocationUpdate is running..................................");

    LatLng oldPos = LatLng(0, 0);

    rideStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      print(
          "inside get position stream ---------------------------------------");
      currentPosition = position;
      myPosition = position;

      print(
          "myposition================================================= ${myPosition}");

      LatLng mPosition = LatLng(position.latitude, position.longitude);

      var rot = MapKitAssistant.getMarkerRotaion(oldPos.latitude,
          oldPos.longitude, myPosition!.latitude, myPosition!.longitude);

      Marker animatingMarker = Marker(
          markerId: MarkerId("animating"),
          position: mPosition,
          icon: animatingMarkerIcon!,
          rotation: rot,
          infoWindow: InfoWindow(title: "Current Location"));

      setState(() {
        CameraPosition cameraPosition =
            new CameraPosition(target: mPosition, zoom: 17);
        newRideGoogleMapControler!
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        markerSet.removeWhere((marker) => marker.markerId.value == "animating");
        markerSet.add(animatingMarker);
      });
      oldPos = mPosition;
      print(
          "almost done get position stream ---------------------------------------");
      updateRideDetails();

      String? rideRequestId = widget.rideDetails.ride_request_id;

      Map locMap = {
        "latitude": currentPosition!.latitude.toString(),
        "longitude": currentPosition!.longitude.toString(),
      };

      newRequestRef.child(rideRequestId!).child("driver_location").set(locMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    createIconMarker();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
                padding: EdgeInsets.only(bottom: mapPaddingFromBottom),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
                markers: markerSet,
                circles: circleSet,
                polylines: polyLineSet,
                onMapCreated: (GoogleMapController controller) async {
                  _controllerGoogleMap.complete(controller);
                  newRideGoogleMapControler = controller;
                  var currentLatLng = LatLng(
                      currentPosition!.latitude, currentPosition!.longitude);
                  var pickUpLatLang = widget.rideDetails.pickup;

                  setState(() {
                    mapPaddingFromBottom = 265;
                  });

                  await getPlaceDirection(currentLatLng, pickUpLatLang!);
                  getRideLocationUpdated();
                }),
            Positioned(
                top: 200,
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
                top: 280,
                left: 20,
                child: Container(
                    height: 60,
                    width: 60,
                    child: GestureDetector(

                      onTap: (){
                        print('clicked on image');
                        openMap(rideDetailsGlobal!.dropoff!.latitude,rideDetailsGlobal!.dropoff!.longitude);
                      },
                      child: Card(

                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset('images/google.png',
                          ),
                        ),
                          // AssetImage(""),
                          // size: 40,
                        ),
                    ),
                    )),

            // Top screen widget
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
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 5,),

                            Icon(
                              Icons.arrow_circle_up,
                              color: Colors.indigo,
                              size: 50,
                            ),
                            SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                (languageEnglish == false)?' Picking Up Rider ' : ' پکنگ اپ رائڈر ',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.rideDetails.pickup_address!,
                                  style: TextStyle(color: Colors.indigo,fontSize: 10),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(color: Colors.indigo)),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: Text('${distanceRide}',
                                        style: TextStyle(color: Colors.indigo,fontSize: 10,fontWeight: FontWeight.bold)),
                                  ),
                                )
                              ],
                            ),

                            SizedBox(width: 10,)
                          ],

                        ),
                      ],
                    )
                    )
                )
            ),
            // Arrived on Spot Widget
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // height 270
                  height: arrivedOnSpotContainerHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          //spreadRadius: 0.5,
                          //  offset: Offset(0.7, 0.7),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120, right: 120),
                          child: Divider(
                            thickness: 3,
                            color: Colors.black26,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          (languageEnglish == false)?' Picking Up Rider ' : ' پکنگ اپ رائڈر ',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
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
                                  durationRide!,
                                  style: TextStyle(
                                      color: Colors.indigo, fontSize: 18),
                                ),
                              ),
                            ),
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
                                  distanceRide!,
                                  style: TextStyle(
                                      color: Colors.indigo, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        AssetImage('images/profile.png'),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.rideDetails.rider_name!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        widget.rideDetails.rider_phone!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          radius: 25,
                                          child: Icon(
                                            Icons.call,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        onTap: () {
                                          launch(
                                              ('tel://${widget.rideDetails.rider_phone!}'));
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ChatHomePage()),
                                          );
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          radius: 25,
                                          child: Icon(
                                            Icons.message,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
                                setState(() {
                                  arrivedOnSpotContainerHeight = 0;
                                  tripInformationContainerHeight = 350;
                                });

                                if (status == "accepted") {
                                  status = 'arrived';
                                  String? rideRequestId =
                                      widget.rideDetails.ride_request_id;
                                  newRequestRef
                                      .child(rideRequestId!)
                                      .child("status")
                                      .set(status);

                                  await getPlaceDirection(
                                      widget.rideDetails.pickup!,
                                      widget.rideDetails.dropoff!);

                                  setState(() {
                                    btnTitle = (languageEnglish == false)?' Start Trip ' : ' سفر شروع کریں ';
                                    btnColor = Colors.purple;
                                  });
                                }
                              },
                              child: Text(
                                (languageEnglish == false)?' Arrived On Spot ' : ' موقع پر پہنچ گئے ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            // Trip information widget
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // height 370
                  height: tripInformationContainerHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          //spreadRadius: 0.5,
                          //  offset: Offset(0.7, 0.7),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120, right: 120),
                          child: Divider(
                            thickness: 3,
                            color: Colors.black26,
                          ),
                        ),
                        Text(
                          (languageEnglish == false)?' Trip Information ' : ' سفر کی معلومات ',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  durationRide!,
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
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
                                  distanceRide!,
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
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
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.indigo,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.rideDetails.dropoff_address!,
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
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
                                      Icons.payments,
                                      color: Colors.indigo,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'RS ${fareRide}',
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
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
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        AssetImage('images/profile.png'),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.rideDetails.rider_name!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        widget.rideDetails.rider_phone!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print('call button clicked');
                                          launch(
                                              ('tel://${widget.rideDetails.rider_phone!}'));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          radius: 25,
                                          child: Icon(
                                            Icons.call,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: (){

                                      },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          radius: 25,
                                          child: Icon(
                                            Icons.message,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
                                if (status == "arrived") {
                                  status = 'onride';
                                  String? rideRequestId =
                                      widget.rideDetails.ride_request_id;
                                  newRequestRef
                                      .child(rideRequestId!)
                                      .child("status")
                                      .set(status);

                                  setState(() {
                                    btnTitle = (languageEnglish == false)?' End Trip ' : ' اختتام سفر ';
                                    btnColor = Colors.red;
                                  });

                                  initTimer();
                                }

                                setState(() {
                                  arrivedOnSpotContainerHeight = 0;
                                  tripInformationContainerHeight = 0;
                                  tripProgressContainerHeight = 270;
                                });
                              },
                              child: Text(
                                (languageEnglish == false)?' Start Trip ' : ' سفر شروع کریں ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            // Trip Progress Weidget
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // height 300
                  height: tripProgressContainerHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          //spreadRadius: 0.5,
                          //  offset: Offset(0.7, 0.7),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120, right: 120),
                          child: Divider(
                            thickness: 3,
                            color: Colors.black26,
                          ),
                        ),
                        Text(
                          (languageEnglish == false)?' Trip Progress ' : ' سفر کی پیشرفت ',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              height: 30,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.white38,
                                onPressed: () {},
                                child: Text(
                                  durationRide!,
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
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
                                  distanceRide!,
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Container(
                          height: 70,
                          // color: Colors.indigo,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
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
                                      width: 10,
                                    ),
                                    Text(
                                      widget.rideDetails.dropoff_address!,
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
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
                                      Icons.payments,
                                      color: Colors.indigo,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'RS ${fareRide}',
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
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

                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 85, right: 85),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: Colors.red,
                              onPressed: () async {
                                setState(() {
                                  arrivedOnSpotContainerHeight = 0;
                                  tripInformationContainerHeight = 0;
                                  tripProgressContainerHeight = 0;
                                  endTripConfirmationContainerHeight = 150;
                                });
                              },
                              child: Text(
                                (languageEnglish == false)?' End Trip ' : ' اختتام سفر ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            // End trip Confirmation
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // height 150
                  height: endTripConfirmationContainerHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          //spreadRadius: 0.5,
                          //  offset: Offset(0.7, 0.7),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120, right: 120),
                          child: Divider(
                            thickness: 3,
                            color: Colors.black26,
                          ),
                        ),

                        Container(
                          width: 300,
                          child: Text(
                            (languageEnglish == false)?' Are You Sure You Want To End The Trip? ' : ' کیا آپ کو یقین ہے کہ آپ سفر ختم کرنا چاہتے ہیں؟ ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.green,
                                onPressed: () {
                                  if (status == 'onride') {
                                    endTheTrip();
                                  }
                                },
                                child: Text(
                                  (languageEnglish == false)?' Yes ' : ' جی ہاں ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    arrivedOnSpotContainerHeight = 0;
                                    tripInformationContainerHeight = 0;
                                    tripProgressContainerHeight = 270;
                                    endTripConfirmationContainerHeight = 0;
                                  });
                                },
                                child: Text(
                                  (languageEnglish == false)?' No ' : ' نہیں ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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



  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Future<void> getPlaceDirection(
      LatLng pickUpLatLng, LatLng dropOffLatLng) async {
    print("getplacedirections executed");

    var details = await AssistantMethods.obtainDirectionDetails(
        pickUpLatLng, dropOffLatLng);

    print('this is encoded point');
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    polylinesCordinates.clear();
    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        polylinesCordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polyLineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
          color: Colors.lightBlueAccent,
          polylineId: PolylineId("PolylineID"),
          jointType: JointType.round,
          points: polylinesCordinates,
          width: 4,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);

      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;

    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    newRideGoogleMapControler!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
    );

    setState(() {
      markerSet.add(pickUpLocMarker);
      markerSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      circleId: CircleId("pickUpId"),
      fillColor: Colors.white,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.yellowAccent,
    );

    Circle dropOffLocCircle = Circle(
      circleId: CircleId("dropOffId"),
      fillColor: Colors.white,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.yellowAccent,
    );

    setState(() {
      circleSet.add(pickUpLocCircle);
      circleSet.add(dropOffLocCircle);
    });
  }

  void acceptRideRequest() {
    String? rideRequestId = widget.rideDetails.ride_request_id;

    newRequestRef
        .child(rideRequestId!)
        .child("driver_name")
        .set(driversInformation!.name);
    newRequestRef
        .child(rideRequestId)
        .child("driver_phone")
        .set(driversInformation!.phone);
    newRequestRef
        .child(rideRequestId)
        .child("driver_id")
        .set(driversInformation!.id);
    newRequestRef.child(rideRequestId).child("car_details").set(
        "${driversInformation!.car_color} - ${driversInformation!.car_model}");

    Map locMap = {
      "latitude": currentPosition!.latitude.toString(),
      "longitude": currentPosition!.longitude.toString(),
    };

    newRequestRef.child(rideRequestId).child("driver_location").set(locMap);

    driverRef
        .child(currentFirebaseUser!.uid)
        .child("history")
        .child(rideRequestId)
        .set(true);
  }

  void updateRideDetails() async {
    print(
        'executing UpdateRideDetails funcion -----------------------------------------------');

    if (isRequestingDirection == false) {
      isRequestingDirection = true;

      if (myPosition == null) {
        return;
      }

      var posLatLng = LatLng(myPosition!.latitude, myPosition!.longitude);
      LatLng destinationLatLng;

      if (status == "accepted") {
        destinationLatLng = widget.rideDetails.pickup!;
      } else {
        destinationLatLng = widget.rideDetails.dropoff!;
      }

      var directionDetails = await AssistantMethods.obtainDirectionDetails(
          posLatLng, destinationLatLng);

      print(
          'printing directionsDetails ---------------------------------------');
      print(directionDetails);

      if (directionDetails != null) {
        setState(() {
          durationRide = directionDetails.durationText;
          distanceRide = directionDetails.distanceText;

          double totalFareAmount = (directionDetails.distanceValue / 1000) * 50;
          fareRide = totalFareAmount.toStringAsFixed(2);
        });
      }
      isRequestingDirection == false;
    }
  }

  void initTimer() {
    const interval = Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      durationCounter = durationCounter + 1;
    });
  }

  endTheTrip() async {
    timer!.cancel();

    var currentLatLng = LatLng(myPosition!.latitude, myPosition!.longitude);

    var directionalDetails = await AssistantMethods.obtainDirectionDetails(
        widget.rideDetails.pickup!, currentLatLng);

    int fareAmount = AssistantMethods.calculateFares(directionalDetails);

    String rideRequestId = widget.rideDetails.ride_request_id!;
    rideRequestIDGlobal = rideRequestId;

    print('Function endThe Trip');
    print('setting status to ended');
    newRequestRef
        .child(rideRequestId)
        .child('fares')
        .set(fareAmount.toString());
    newRequestRef.child(rideRequestId).child('status').set('ended');
    rideStreamSubscription!.cancel();
    saveEarning(fareAmount);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TotalFare()), (route) => false);
  }

  void saveEarning(int fareAmount) {
    driverRef
        .child(currentFirebaseUser!.uid)
        .child('earnings')
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snap = event.snapshot;

      print('Function saveEarning');

      if (snap.exists) {
        double oldEarning = double.parse(snap.value.toString());
        double totalEarnings = fareAmount + oldEarning;

        print('Setting up fare in IF');

        driverRef
            .child(currentFirebaseUser!.uid)
            .child('earnings')
            .set(totalEarnings.toStringAsFixed(2));
      } else {
        double totalEarnings = fareAmount.toDouble();
        print('Setting up fare in ELSE');

        driverRef
            .child(currentFirebaseUser!.uid)
            .child('earnings')
            .set(totalEarnings.toStringAsFixed(2));
      }
    });
  }
}
