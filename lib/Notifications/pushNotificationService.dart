import 'dart:io';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riorider/Models/rideDetails.dart';
import 'package:riorider/Notifications/notification_dialog.dart';
import 'package:riorider/config.dart';
import 'package:riorider/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class PushNotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String notificationMsg = "waiting for Notification";

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    print("initializing Notifications ...................................");

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      print(payload);
    });

    late final FirebaseMessaging _messaging;

    _messaging = FirebaseMessaging.instance;

    var settinx = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settinx.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted the Permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        showNotificationOnForeground(event);
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
      });
    }

    //onmessage is we app is opened
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        notificationMsg =
            "${value.notification!.title} body ${value.notification!.body} I am coming from terminated state";
        print(notificationMsg);
      } else {
        print(
            "no notification value.....................................................");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      notificationMsg =
          "${event.notification!.title} body ${event.notification!.body} I am coming from background";
      print(notificationMsg);
    });
  }
  //getInitialMessage is called

  Future<String?> getToken() async {
    print("getToken Executed -----------------------------------");
    String? token;

    // firebaseMessaging.getToken().then((value) {
    //   print('tooken try 2');
    //   print(value);
    // });

    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
    }).onError((error, stackTrace) {
      print("This not recived Token ::");
      print(error);
    });

    print("This is Token ::");
    print(token);

    driverRef.child(currentFirebaseUser!.uid).child("token").set(token);

    firebaseMessaging.subscribeToTopic("alldrivers");
    firebaseMessaging.subscribeToTopic("allusers");

    return token;
  }

  String getRideRequestId(Map<String, dynamic> message) {
    String rideRequestId = "";
    if (Platform.isAndroid) {
      rideRequestId = message['data']['ride_request_id'];

      print("This is Ride Request ID Android::");
      print(rideRequestId);
    } else {
      rideRequestId = message['ride_request_id'];
    }

    return rideRequestId;
  }

  //show the dialog when app is already opened
  static void showNotificationOnForeground(RemoteMessage message) {
    print("show Notification On Foreground called ...................");
    print("message: ${message}");

    final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "com.rio.driver_side_complete", "riorider",
            importance: Importance.max, priority: Priority.high));

    print(notificationDetails);
    print(message.notification!.title);

    Random random = new Random();

    _notificationsPlugin.show(random.nextInt(100), message.notification!.title,
        message.notification!.body, notificationDetails,
        payload: message.data['message']);
  }

  // he pass it to onMessage to recive and on  all

  void retrieveRideRequestInfo(
      String rideRequestId, BuildContext context) async {
    DatabaseReference reference = await FirebaseDatabase.instance
        .ref()
        .child("Ride Requests")
        .child(rideRequestId);

    DatabaseEvent event = await reference.once();

    DataSnapshot dataSnapshot = event.snapshot;

    print("DataBase SnapShot ${dataSnapshot.value}");

    var data = dataSnapshot.value as Map;

    print(dataSnapshot.value);

    if (data != null) {
      assetsAudioPlayer.open(Audio("sounds/alert.mp3"),
          autoStart: true, showNotification: true);
      assetsAudioPlayer.play();

      double pickUpLocationLat =
          double.parse(data!['pickup']['latitude'].toString());
      double pickUpLocationlng =
          double.parse(data['pickup']['longitude'].toString());
      String pickUpAddress = data['pickup_address'].toString();
      print(pickUpLocationlng);

      double dropOffLocationLat =
          double.parse(data['dropoff']['latitude'].toString());
      double dropOffLocationlng =
          double.parse(data['dropoff']['longitude'].toString());
      String dropOffAddress = data['dropoff_address'].toString();

      String paymentMethod = data['dropoff_address'].toString();

      String rider_name = data['rider_name'];
      String rider_phone = data['ride_phone'];

      RideDetails rideDetails = RideDetails(
          ride_request_id: rideRequestId,
          pickup_address: pickUpAddress,
          dropoff_address: dropOffAddress,
          pickup: LatLng(pickUpLocationLat, pickUpLocationlng),
          dropoff: LatLng(dropOffLocationLat, dropOffLocationlng),
          payment_method: paymentMethod,
          rider_name: rider_name,
          rider_phone: rider_phone);

      print("Ride Request Informaition------------------------");
      print(rideDetails.pickup_address);
      print(rideDetails.dropoff_address);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotificationDialog(rideDetails));
    } else {
      print("Ride Request Snapshot doesnt exists-------------------------");
    }
  }
}
