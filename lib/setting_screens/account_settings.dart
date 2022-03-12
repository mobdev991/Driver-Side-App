import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riorider/config.dart';
import 'package:riorider/setting_screens/edit_information.dart';

import '../main.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String vehicalModel = "";
  String vehicalRegNo = "";
  String vehicalColor = "";

  @override
  void initState() {
    assigningValues();
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 70,
                  ),
                  Text(
                    'Account Settings',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('images/profile.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 10, left: 15, right: 15),
              child: Column(

                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                    Text('Edit Profile',style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.red.shade700,
                      iconSize: 20,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditInfo()));
                      },
                    ),
                  ],),
                  Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.grey, width: 2)
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Full Name',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  userName,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ]))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.grey, width: 2)
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email Address',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  userEmail,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ]))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.grey, width: 2)
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Phone',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  userPhone,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ]))),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Vehicle Details",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.grey, width: 2)
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Model',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  vehicalModel,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ]))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.grey, width: 2)
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Registration Number',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  vehicalRegNo,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ]))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.grey, width: 2)
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Color',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  vehicalColor,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ]))),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Account Status',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'ACTIVE',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void assigningValues() {
    print('assign');
    driverRef
        .child(currentFirebaseUser!.uid)
        .child('car_details')
        .child('car_color')
        .once()
        .then((DatabaseEvent event) {
      print("datasnap value in makedriver online");
      DataSnapshot snap = event.snapshot;
      print(snap.value);
      if (snap.exists) {
        setState(() {
          vehicalColor = snap.value.toString();
        });
      } else {
        print(snap.exists);
      }
    });

    driverRef
        .child(currentFirebaseUser!.uid)
        .child('car_details')
        .child('car_model')
        .once()
        .then((DatabaseEvent event) {
      print("datasnap value in makedriver online");
      DataSnapshot snap = event.snapshot;
      print(snap.value);
      if (snap.exists) {
        setState(() {
          vehicalModel = snap.value.toString();
        });
      }
    });

    driverRef
        .child(currentFirebaseUser!.uid)
        .child('car_details')
        .child('car_number')
        .once()
        .then((DatabaseEvent event) {
      print("datasnap value in makedriver online");
      DataSnapshot snap = event.snapshot;
      print(snap.value);
      if (snap.exists) {
        setState(() {
          vehicalRegNo = snap.value.toString();
        });
      }
    });

    // user info

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
          userName = snap.value.toString();
        });
      }
    });

    driverRef
        .child(currentFirebaseUser!.uid)
        .child('email')
        .once()
        .then((DatabaseEvent event) {
      print("datasnap value in makedriver online");
      DataSnapshot snap = event.snapshot;
      print(snap.value);
      if (snap.exists) {
        setState(() {
          userEmail = snap.value.toString();
        });
      }
    });

    driverRef
        .child(currentFirebaseUser!.uid)
        .child('phone')
        .once()
        .then((DatabaseEvent event) {
      print("datasnap value in makedriver online");
      DataSnapshot snap = event.snapshot;
      print(snap.value);
      if (snap.exists) {
        setState(() {
          userPhone = snap.value.toString();
        });
      }
    });
  }
}
