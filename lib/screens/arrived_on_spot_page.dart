import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:riorider/Assistance/assistanceMethods.dart';
import 'package:riorider/Assistance/mapKitAssistant.dart';
import 'package:riorider/Models/rideDetails.dart';
import 'package:riorider/config.dart';
import 'package:riorider/main.dart';
import 'package:riorider/providers/appData.dart';
import 'package:riorider/widgets/collect_fare_dialog.dart';
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
  bool isRequestingDirection = false;

  String btnTitle = "Arrived";
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
                                        '${durationRide} away',
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
                                      widget.rideDetails.rider_name!,
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
                              if (status == "accepted") {
                                status = 'arrived';
                                String? rideRequestId =
                                    widget.rideDetails.ride_request_id;
                                newRequestRef
                                    .child(rideRequestId!)
                                    .child("status")
                                    .set(status);

                                setState(() {
                                  btnTitle = "Start";
                                  btnColor = Colors.purple;
                                });

                                await getPlaceDirection(
                                    widget.rideDetails.pickup!,
                                    widget.rideDetails.dropoff!);
                              } else if (status == "arrived") {
                                status = 'onride';
                                String? rideRequestId =
                                    widget.rideDetails.ride_request_id;
                                newRequestRef
                                    .child(rideRequestId!)
                                    .child("status")
                                    .set(status);

                                setState(() {
                                  btnTitle = "End Trip";
                                  btnColor = Colors.red;
                                });

                                initTimer();
                              } else if (status == 'onride') {
                                endTheTrip();
                              }
                            },
                            child: Text(
                              btnTitle,
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
    newRequestRef.child(rideRequestId!).child("status").set("accepted");

    newRequestRef
        .child(rideRequestId!)
        .child("driver_name")
        .set(driversInformation!.name);
    newRequestRef
        .child(rideRequestId!)
        .child("driver_phone")
        .set(driversInformation!.phone);
    newRequestRef
        .child(rideRequestId!)
        .child("driver_id")
        .set(driversInformation!.id);
    newRequestRef.child(rideRequestId!).child("car_details").set(
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
    newRequestRef
        .child(rideRequestId)
        .child('fares')
        .set(fareAmount.toString());
    newRequestRef.child(rideRequestId).child('status').set('ended');
    rideStreamSubscription!.cancel();

    showDialog(
        context: context,
        builder: (BuildContext context) => CollectFareDialog(
            paymentMethod: widget.rideDetails.payment_method!,
            fareAmount: fareAmount));

    saveEarning(fareAmount);
  }

  void saveEarning(int fareAmount) {
    driverRef
        .child(currentFirebaseUser!.uid)
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snap = event.snapshot;

      if (snap.exists) {
        double oldEarning = double.parse(snap.value.toString());
        double totalEarnings = fareAmount + oldEarning;

        driverRef
            .child(currentFirebaseUser!.uid)
            .child('earnings')
            .set(totalEarnings.toStringAsFixed(2));
      } else {
        double totalEarnings = fareAmount.toDouble();

        driverRef
            .child(currentFirebaseUser!.uid)
            .child('earnings')
            .set(totalEarnings.toStringAsFixed(2));
      }
    });
  }
}
