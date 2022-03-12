import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../widgets/signup_form.dart';

import '../theme.dart';

class SignUpScreen extends StatelessWidget {
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
                    'Create Your Rio account to get started',
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
              child: SignUpForm(),
            ),
            SizedBox(
              height: 10,
            ),

            //GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => Otp(),
            //           ));
            //     },
            //     child: PrimaryButton(
            //       buttonText: 'Create Account',
            //       isLogin: false,
            //       onTap: () {},
            //     ),
            // Padding(
            //   padding: kDefaultPadding,
            //   child: PrimaryButton(buttonText: 'Create Account'),
            // ),

            Padding(
              padding: kDefaultPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Already a member?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()));
                    },
                    child: Text(
                      'Log In',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                        fontSize: 14
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
