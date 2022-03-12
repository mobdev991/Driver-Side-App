import 'dart:async';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:riorider/Assistance/assistanceMethods.dart';
import 'package:riorider/Models/drivers.dart';
import 'package:riorider/Notifications/awesome_notifications.dart';
import 'package:riorider/Notifications/notifications.dart';
import 'package:riorider/Notifications/pushNotificationService.dart';
import 'package:riorider/chat_packages/chat_home.dart';
import 'package:riorider/config.dart';
import 'package:riorider/main.dart';
import 'package:riorider/providers/appData.dart';
import 'package:riorider/screens/Home_page_two.dart';
import 'package:riorider/screens/earning_page.dart';
import 'package:riorider/screens/job_history.dart';
import 'package:riorider/screens/login.dart';
import 'package:riorider/screens/rider_notification_page.dart';
import 'package:riorider/setting_screens/aboutUs_screen.dart';
import 'package:riorider/setting_screens/main_setting_screen.dart';
import 'package:riorider/widgets/signup_form.dart';
import '../Models/direactionDetails.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
DatabaseReference rideRequestRef = FirebaseDatabase.instance
    .ref()
    .child("drivers")
    .child(currentFirebaseUser!.uid)
    .child("newRide");
class _HomePageState extends State<HomePage> with TickerProviderStateMixin,WidgetsBindingObserver{
  GlobalKey<ScaffoldState> _scaffoldKEY = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  PushNotificationService pushee = PushNotificationService();

  bool appPermissioncheck = true;

  DirectionDetails? tripDirectionDetails;

  var geoLocator = Geolocator();

  String driverStatusText = (languageEnglish == false)?' Offline ' : ' آف لائن ';
  Color driverStatusColor = Colors.black12;
  bool isDriverAvailable = false;
  Color containerColor = Colors.white60;
  String driverName = 'Best Driver';

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double bottomPaddingMap = 100;

  double maindialogContainerHeight = 0;
  double warningWidgetHeight = 60;
  double warningIconSize = 35;

  DatabaseReference? rideRequestRef;
  String notificationMsg = 'Waiting for Notifications';

  double goContainerHeight = 150;
  double notificationContainerHeight = 0;
  bool showNotification = false;

  @override
  void initState() {
    print("initstate-------------------------------in");
    print(languageEnglish);
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    getCurrentDriverInfo();
    AssistantMethods.getCurrentOnLineUserInfo(context);
    print('print ------------------------------------- ride status');
    print(onlineOrOffline);
    if( onlineOrOffline == "online"){
      driverStatusColor = Colors.green;
      driverStatusText = (languageEnglish == false)?' Online ' : ' آن لائن ';
      isDriverAvailable = true;
      containerColor = kOffWhiteOfBack;
      print('make driver online exicutedd === ');
      makeDriverOnlineNow();

    }



    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if(!isAllowed){
        print('Awesome Notification Permisson is not allowed');

        showDialog(
            context: context, builder: (context) => AlertDialog(title: Text('Allow Notifications'),
        content: Text('Our App Would Like To Send You Notifications'),
            actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Deny')),
            TextButton(onPressed: ()=> AwesomeNotifications().requestPermissionToSendNotifications().then((_)=>Navigator.pop(context)), child: Text('Allow'))
            ]),);
      }else{
        print('Awesome Notification Permisson is allowed');
      }
    }
    );


  }


  @override
  void dispose() {
    print('super dispose Appo');

    makeDriverOfflineNow();
    super.dispose();
    print(' disposed App');
    WidgetsBinding.instance?.removeObserver(this);

  }



  @override
  void deactivate() {
    print('deactivare Appo');

    makeDriverOfflineNow();
    super.deactivate();
    print('super deactivare Appo');
  }

  void mapInitialized
        (GoogleMapController controller) {
    print('google map controller called');
      _controllerGoogleMap.complete(controller);
      newGoogleMapControler = controller;
      checkPermission();
      getCurrentLocation();
    }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
print(state);
    if(state == AppLifecycleState.resumed){
      print(' app is resumed---------');

      var status = await Permission.location.status;
      if(status.isGranted){
        print('in warning button ------- location is granted');

          hideWarningWidget();
          newGoogleMapControler?.setMapStyle("[]");
       if(appPermissioncheck == false){
         appPermissioncheck =true;
         print('apppermissionchec = ' + appPermissioncheck.toString());
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => HomePage()));
       }else{
         print('else apppermissionchec = ' + appPermissioncheck.toString());
       }

      }else {
        print('in warning button ------- location is NOT granted');

        showWarningWidget();


      }

    }else if(state == AppLifecycleState.inactive){
      print(' app is inactive---------');
    }else if(state == AppLifecycleState.detached){
      makeDriverOfflineNow();
      print(' app is detached---------');
    }else if(state == AppLifecycleState.paused){
      print(' app is pasued---------');
      // setState(() {
      //   driverStatusColor = Colors.black12;
      //   driverStatusText = ' Offline ';
      //   isDriverAvailable = false;
      //   containerColor = Colors.white60;
      // });
      // makeDriverOfflineNow();
    }else{
      print('unknown App State');
    }
  } // void locatePosition() async {
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
                            "images/profile.png",
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          driverName,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatHomePage()),
                  );
                },
              ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EarningPage()));
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobNotifications()),
                  );
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Setting()));
                },
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OnlineSupport()));
                },
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
                  polylines: polylineSet,
                  markers: markersSet,
                  circles: circlesSet,
                  onMapCreated:mapInitialized

                  ),
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
                          driverName = userCurrentInfo!.name!;
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
                        icon: Icon(Icons.notifications_on),
                        color: Colors.indigo,
                        iconSize: 35,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notifications()));
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
                        onPressed: () async{

                          var status = await Permission.location.status;
                          if(status.isGranted){
                            print('in warning button ------- location is granted');
                            getCurrentLocation();

                          }else {

                            showRequestPermissionDialog();
                          }

                        },
                      ),
                    ))),
            Positioned(
                top: 280,
                right: 20,
                child: Container(
                    height: warningWidgetHeight,
                    child: Card(
                      child: IconButton(
                        icon: Icon(Icons.warning),
                        color: Colors.red.shade700,
                        iconSize: warningIconSize,
                        onPressed: () async{
                          var status = await Permission.location.status;
                          if(status.isGranted){
                            print('in warning button ------- location is granted');
                            hideWarningWidget();
                          }else {
                            print('in warning button ------- location is NOT granted');
                            showRequestPermissionDialog();
                          }
                        },
                      ),
                    ))),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: goContainerHeight,
                decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                  child: MaterialButton(
                    color: driverStatusColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () async{
                      var status = await Permission.location.status;
                      if(status.isGranted){
                        print("go clicked");
                        if (isDriverAvailable != true) {
                          print(languageEnglish);
                          makeDriverOnlineNow();
                          getLocationLiveUpdates();

                          setState(() {
                            driverStatusColor = Colors.green;
                            driverStatusText = (languageEnglish == false)?' Online ' : ' آن لائن ';
                            isDriverAvailable = true;
                            containerColor = kOffWhiteOfBack;
                          });
                        } else {
                          setState(() {
                            driverStatusColor = Colors.black12;
                            driverStatusText = (languageEnglish == false)?' Offline ' : ' آف لائن ';
                            isDriverAvailable = false;
                            containerColor = Colors.white60;
                          });

                          makeDriverOfflineNow();
                        }
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => FarePage()));
                      }else{
                        print('dnt have permission --------------------------');
                        displayToastMessage('Need Location Permission', context);
                      }
                    },
                    child: Text(
                      driverStatusText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            // RiderNotification(containerHeight: notificationContainerHeight)
          ],
        ),
      ),
    );
  }


  void getCurrentLocation() async {
    print('GetCurrent Lcoation executed');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // currentPosition = position;

    print('GetCurrent  executed');
    LatLng currentPosition = LatLng(position.latitude, position.longitude);
    print('GetCurrent Lcoation ');
    CameraPosition cameraPositionuser =
        new CameraPosition(target: currentPosition, zoom: 14);

    newGoogleMapControler!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPositionuser));
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

    pushee.showNotificationDialog(context);
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
    print(rideRequestRef!.key);
    rideRequestRef!.onDisconnect();
    rideRequestRef!.set('offline');
    print('your are offline-----------------------------------------');
    print(rideRequestRef!.key);
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

    pushNotificationService.initialize(context);
    pushNotificationService.getToken();

    assignDriverInfo();

    AssistantMethods.retriveHistoryInfo(context);
  }

  void assignDriverInfo() {
    driverRef
        .child(currentFirebaseUser!.uid)
        .child('name')
        .once()
        .then((DatabaseEvent event) {
      print("datasnap value in makedriver online");
      DataSnapshot snap = event.snapshot;
      print(snap.value);
      if (snap.exists) {
        setState(() {
          driverName = snap.value.toString();
        });

        print('driver Name :: ${driverName}');
      }
    });
  }

  void checkPermission() async{
    var status = await Permission.location.status;

    if(status.isDenied){
print('location permission is denied..............................');
showWarningWidget();
    }else{

      print('location permission is NOT denied..............................');
    }

    if(status.isRestricted){
print('location permission is Restricted..............................');
showWarningWidget();
    }else{

      print('location permission is NOT Restricted..............................');
    }

    if(status.isPermanentlyDenied){
print('location permission is PermanentlyDenied..............................');
showWarningWidget();
    }else{

      print('location permission is NOT PermanentalyDenied..............................');
    } if(status.isGranted){
print('location permission is Granted..............................');
hideWarningWidget();
    }else{

     showWarningWidget();
showRequestPermissionDialog();

    }


  }

  void showWarningWidget(){
warningWidgetHeight = 60;
warningIconSize = 35;
  }
  void hideWarningWidget(){
warningWidgetHeight = 0;
warningIconSize = 0;
  }

  void showRequestPermissionDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('Location Permission',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo)),
          content: Text(
              'Rio Drive collects location Data to enable "Ride Request" and "Location Tracking" Features, even when the app is closed or not in use', style: TextStyle(fontSize: 15,),),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Deny',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text('Allow',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo)),
              onPressed: () {
                appPermissioncheck = false;
                Permission.location.request();
                Navigator.pop(context);


              },
            ),
          ],
        ));
  }
}
