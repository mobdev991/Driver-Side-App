import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Center(
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
                          width: 50,
                        ),
                        TextButton(
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Container(
            //     height: 80,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       color: Colors.lightBlue[100],
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Column(
            //       children: [
            //         Padding(
            //           padding:
            //               const EdgeInsets.only(top: 20, left: 10, right: 20),
            //           child: Column(
            //             children: [
            //               Row(
            //                 children: [
            //                   Icon(
            //                     Icons.drive_eta,
            //                     size: 40,
            //                   ),
            //                   SizedBox(
            //                     width: 35,
            //                   ),
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         'No Import Notifications',
            //                         style: TextStyle(
            //                             color: Colors.indigo,
            //                             fontSize: 16,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                       Text(
            //                         'Body of Notification',
            //                         style: TextStyle(
            //                           color: Colors.indigo,
            //                         ),
            //                       )
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            Text(
              'No Important Notification To Show',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black26),
            ),
          ],
        ),
      ),
    );
  }
}
