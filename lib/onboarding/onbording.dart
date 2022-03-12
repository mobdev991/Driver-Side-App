import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:riorider/screens/Home_page.dart';
import '../onboarding/MyHomePage.dart';

class Onbording extends StatelessWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home:
          FirebaseAuth.instance.currentUser == null ? MyHomePage() : HomePage(),
    );
  }
}
