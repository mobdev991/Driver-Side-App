import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/signup.dart';
import '../widgets/login_form.dart';

import '../theme.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
                'Welcome Back!',
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Login to your Rio Account to get started ',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),


              SizedBox(
                height: 10,
              ),
              LogInForm(),
              // PrimaryButton(
              //   buttonText: 'Log In',
              //   onTap: () {},
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Dont have an account? ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      ' Sign Up',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                        color: Colors.indigo,fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account",
          style: TextStyle(color: Colors.redAccent),
        ),
      ],
    );
  }
}
