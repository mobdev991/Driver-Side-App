import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riorider/config.dart';
import 'package:riorider/screens/car_info_screen.dart';

import '../main.dart';
import '../screens/Home_page.dart';

import '../setting_screens/policy_screen.dart';
import '../theme.dart';
import '../widgets/primary_button.dart';
import '../screens/otp_screen.dart';
import '../widgets/checkbox.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  static const String screenId = "login";
  bool _isObscure = true;

  bool errorSignUp = false;
  bool checkedValue = false;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          errorSignUp == false ? "" : 'Invalid Formate : Too Short',
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: _nameTextController,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
          ],
          decoration: InputDecoration(
            hintText: 'Name',
            hintStyle: TextStyle(color: kTextFieldColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),

          ),
        ),
        // buildInputForm('Last Name', false),
        buildInputForm('Email', false, _emailTextController),
        // buildInputForm('Phone   e.g  0303XXXXXXX', false, _phoneTextController),

        TextFormField(
          controller: _phoneTextController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            hintText: 'Phone   e.g  0303XXXXXXX',
            hintStyle: TextStyle(color: kTextFieldColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),

          ),
        ),

        buildInputForm('Password', true, _passwordTextController),

        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: CheckboxListTile(
            title: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppPrivacy()));

                },
                child: Text('Agree to terms and conditions.',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold))),
            value: checkedValue,
            onChanged: (newValue) {
              setState(() {
                checkedValue = newValue!;
                print(newValue);
              });
            },
            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
          )

        ),
        // buildInputForm('Confirm Password', true),



        PrimaryButton(
            buttonText: 'Create Account',
            onTap: () {
              if (_passwordTextController.text.length < 6) {
                displayToastMessage("Password Too Short", context);
              } else if (_nameTextController.text.length < 3) {
                setState(() {
                  errorSignUp = true;
                });
              } else if (!_emailTextController.text.contains("@") &&
                  !_emailTextController.text.contains(".")) {
                displayToastMessage("Invalid Email", context);
              } else if (_phoneTextController.text.length == null || _phoneTextController.text.length != 11 ) {
                displayToastMessage("Enter Valid Phone Nubmber", context);
              } else {

              }
              }


            ),
      ],
    );
  }

  Padding buildInputForm(
      String hint, bool pass, TextEditingController controller) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: controller,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: kTextFieldColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
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
                          ))
                : null,
          ),
        ));
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    print("enterend registernew user -----------------------------------");
    final User? firebaseUser = (await auth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .catchError((errMsg) {
      displayToastMessage(errMsg + "Error Creating New User", context);
    }))
        .user;
    if (firebaseUser != null) //user created
    {
      // save his info
      //
      driverRef.child(firebaseUser.uid);

      Map userDataMap = {
        "name": _nameTextController.text.trim(),
        "email": _emailTextController.text.trim(),
        "phone": _phoneTextController.text.trim(),
      };

      driverRef.child(firebaseUser.uid).set(userDataMap);

      currentFirebaseUser = firebaseUser;

      displayToastMessage("Account Created", context);

      print("accout------created------");
    } else {
      displayToastMessage("UserNotCreated", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
