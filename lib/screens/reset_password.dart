import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login.dart';
import '../theme.dart';
import '../widgets/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _TextController = TextEditingController();
  bool inputError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ SizedBox(
                  height: 30,
                ),
                  Container(
                    height: 140,
                    width: 130,
                    //height: MediaQuery.of(context).size.height/4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/Rio Logo.png"))),
                  ),
                  Text(
                    'Reset Password',
                    style: titleText,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Please enter your email address',
                    style: subTitle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    inputError == false ? "" : 'Email address is not registered!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _TextController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(),
                    style: TextStyle(letterSpacing: 1, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
              Column(
                children: [ GestureDetector(
                    onTap: () {
                      print("detector");
                    },
                    child: PrimaryButton(
                      buttonText: 'Reset Password',
                      onTap: () async {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _TextController.text)
                            .then((value) {
                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) => LogInScreen()));
                        }).onError((error, stackTrace) {
                          setState(() {
                            inputError = true;
                          });
                        });
                      },
                    )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 50, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'or  ',
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
                              decorationThickness: 1,fontSize: 14
                            ),
                          ),
                        )
                      ],
                    ),
                  ),],
              ),
             ]
          ),
        ),
      ),
    );
  }
}
