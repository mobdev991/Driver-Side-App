import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riorider/config.dart';
import 'package:riorider/providers/appData.dart';

import '../main.dart';

class EarningPage extends StatefulWidget {
  const EarningPage({Key? key}) : super(key: key);

  @override
  State<EarningPage> createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  String totalEarning = 'RS 00.00';
  int totalTrips = 0;

  @override
  void initState() {
    assignValues();
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
                    'Earning Report',
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 18, left: 15, right: 15),
              child: Column(
                children: [
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
                                  'Total Earnings',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'RS ${totalEarning}',
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
                                  'Earned Today',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'N/A',
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
                                  'Trips Completed',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  "${totalTrips}",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ]))),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  void assignValues() {
    totalEarning = Provider.of<AppData>(context, listen: false).earnings;
    totalTrips = Provider.of<AppData>(context, listen: false).numberOfTrips;
    // driverRef
    //     .child(currentFirebaseUser!.uid)
    //     .child('earnings')
    //     .once()
    //     .then((DatabaseEvent event) {
    //   print("datasnap value in makedriver online");
    //   DataSnapshot snap = event.snapshot;
    //   print(snap.value);
    //   if (snap.exists) {
    //     setState(() {
    //       totalEarning = snap.value.toString();
    //     });
    //   } else {
    //     setState(() {
    //       totalEarning = 'RS 00';
    //     });
    //   }
    // });
  }
}
