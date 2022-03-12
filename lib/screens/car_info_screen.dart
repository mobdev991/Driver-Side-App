import 'package:flutter/material.dart';
import 'package:riorider/screens/signup.dart';
import 'package:riorider/widgets/car_info_form.dart';

import '../theme.dart';

class CarInfoScreen extends StatelessWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                height: 140,
                width: 130,
                //height: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/Rio Logo.png"))),
              ),
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Welcome',
                style: titleText,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Row(
                children: [
                  Text(
                    'Register Your Vehical',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: kDefaultPadding,
              child: CarInfoForm(),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
