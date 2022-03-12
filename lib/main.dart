import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:riorider/config.dart';
import 'package:riorider/providers/appData.dart';
import 'package:firebase_database/firebase_database.dart';

import '../onboarding/onbording.dart';
import '../Phase_one/Splash_screen.dart';
import '../Phase_one/Welcome_page.dart';
import '../Phase_one/loginoption_page.dart';
import './Route_page.dart';
import 'package:provider/provider.dart';

Future<void> backGroundHandler(RemoteMessage message) async {
  print("This is message from spirt");
  print(message.notification!.title);
  print(message.notification!.body);
  print(message);
}



void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize('resource://drawable/ic_launcher', [NotificationChannel(channelKey: 'basic_channel',
      channelName: 'New Ride Request Recivied',importance: NotificationImportance.High,
      defaultColor: Colors.white10,
      channelDescription: 'channelDescription',
  vibrationPattern: highVibrationPattern,
  playSound: true,
      soundSource: 'resource://raw/alert'
  )]);
  await Firebase.initializeApp();

  currentFirebaseUser = FirebaseAuth.instance.currentUser;


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppData()),
    ],
    child: MyApp(),
  ));
  print("main executted");

}

DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers");
DatabaseReference newRequestRef =
    FirebaseDatabase.instance.ref().child("Ride Requests");

DatabaseReference rideRequestRef = FirebaseDatabase.instance
    .ref()
    .child("drivers")
    .child(currentFirebaseUser!.uid)
    .child("newRide");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login",
        theme: ThemeData(primaryColor: Colors.indigo),
        routes: <String, WidgetBuilder>{
          splash_Screen: (BuildContext context) => SplashScreen(),
          loginoption_page: (BuildContext context) => const loginoption(),
          onbordingscreen: (BuildContext context) => Onbording(),
        },
        initialRoute: splash_Screen,
      ),
    );
  }
}
