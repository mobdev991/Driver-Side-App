import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riorider/config.dart';
import 'package:riorider/main.dart';
import 'package:riorider/onboarding/MyHomePage.dart';
import 'package:riorider/screens/signup.dart';

import '../theme.dart';
import '../widgets/primary_button.dart';
import '../screens/Home_page.dart';
import '../screens/reset_password.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool signinError = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isObscure = true;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          signinError == false ? "" : 'Invalid Email or Password!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        buildInputForm('Email', false, _emailTextController),
        buildInputForm('Password', true, _passwordTextController),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswordScreen()));
              },
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        PrimaryButton(
          buttonText: 'Login In',
          onTap: () {
            loginAndAuthenticateUser(context);
          },
        ),
      ],
    );
  }

  Padding buildInputForm(
      String label, bool pass, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    print(
        "login and auth user method called ---------------------------------------");
    final User? firebaseUser = (await auth
            .signInWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .catchError((errMsg) {
      displayToastMessage("Error", context);
    }))
        .user;

    if (firebaseUser != null) {
      DatabaseReference reference = driverRef.child(firebaseUser.uid);
      DatabaseEvent event = await reference.once();

      DataSnapshot snap = event.snapshot;

      if (snap.exists) {
        currentFirebaseUser = firebaseUser;

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        displayToastMessage("Logged In", context);
      } else {
        _firebaseAuth.signOut();
        displayToastMessage("no record exists", context);
      }
    } else {
      displayToastMessage("error while signing in", context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
