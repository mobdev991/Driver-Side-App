import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riorider/config.dart';
import 'package:riorider/screens/Home_page.dart';
import 'package:riorider/screens/login.dart';
import 'package:riorider/widgets/primary_button.dart';

import '../main.dart';
import '../theme.dart';
import 'checkbox.dart';

class CarInfoForm extends StatefulWidget {
  const CarInfoForm({Key? key}) : super(key: key);

  @override
  _CarInfoFormState createState() => _CarInfoFormState();
}

class _CarInfoFormState extends State<CarInfoForm> {
  static const String screenId = "login";
  bool _isObscure = true;

  bool errorSignUp = false;

  TextEditingController _regNoTextController = TextEditingController();
  TextEditingController _vehicalNameTextController = TextEditingController();
  TextEditingController _vehicalColorTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildInputForm('Vehical Model   e.g Mehran', false, _vehicalNameTextController),
        // buildInputForm('Last Name', false),
        buildInputForm('Registration Number    e.g  LXR 999', false, _regNoTextController),
        buildInputForm('Vehical Color  e.g  Black', false, _vehicalColorTextController),

        Text(
          errorSignUp == false ? "" : 'Invalid Formate : Too Short',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(
          height: 10,
        ),
        PrimaryButton(
            buttonText: 'Create Account',
            onTap: () {
              if (_regNoTextController.text.isEmpty) {
                displayToastMessage(
                    "Please Enter Vehical Registration Number", context);
              } else if (_vehicalNameTextController.text.isEmpty) {
                setState(() {
                  displayToastMessage("Enter Vehical Model Number", context);
                  errorSignUp = true;
                });
              } else if (_vehicalColorTextController.text.isEmpty) {
                displayToastMessage("Please Enter Vehical Number", context);
              } else {
                saveDriverCarInfo(context);
              }
            }),
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

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  void saveDriverCarInfo(BuildContext context) async {
    String userId = currentFirebaseUser!.uid;

    print(currentFirebaseUser);
    print("----------current user------------------------");
    Map carInfoMap = {
      "car_color": _vehicalColorTextController.text.trim(),
      "car_model": _vehicalNameTextController.text.trim(),
      "car_number": _regNoTextController.text.trim(),
    };

    print("details input ------------------");
    print(carInfoMap);

    driverRef
        .child(userId)
        .child("car_details")
        .set(carInfoMap)
        .onError((error, stackTrace) {
      print("vehicle registration error  ${error}");
    }).then((value) {
      print("vehivale registered");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
          (route) => false);
    });
  }
}
