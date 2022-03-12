import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class EditInfoForm extends StatefulWidget {
  @override
  _EditInfoFormState createState() => _EditInfoFormState();
}

class _EditInfoFormState extends State<EditInfoForm> {
  static const String screenId = "login";
  bool _isObscure = true;

  bool errorSignUp = false;
  bool checkedValue = false;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _regNoTextController = TextEditingController();
  TextEditingController _vehicalNameTextController = TextEditingController();
  TextEditingController _vehicalColorTextController = TextEditingController();

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
        buildInputForm('Name', false, _nameTextController),
        // buildInputForm('Last Name', false),
        buildInputForm('Phone   e.g  0303XXXXXXX', false, _phoneTextController),
        // buildInputForm('Vehical Model   e.g Mehran', false, _vehicalNameTextController),
        // // buildInputForm('Last Name', false),
        // buildInputForm('Registration Number    e.g  LXR 999', false, _regNoTextController),
        // buildInputForm('Vehical Color  e.g  Black', false, _vehicalColorTextController),

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
                  child: Text('Agree to terms and conditions.',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),)),
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
            buttonText: 'Done',
            onTap: () {

            if (_nameTextController.text.length < 3) {
                setState(() {
                  errorSignUp = true;
                });
              } else if (_vehicalNameTextController.text.length == null) {
                displayToastMessage("Empty Vehicale Name", context);
              } else if (_regNoTextController == null) {
                displayToastMessage("Empty Vehicale Registration Number", context);
              } else if (_vehicalColorTextController == null) {
                displayToastMessage("Empty Vehicale Color", context);
              } else {
                if(checkedValue== true){
                  print('car info screen');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()));
                  updateUserInfo(context);
                }else{
                  displayToastMessage('Agree to TOS', context);
                }
              }
              //verifyPhoneNumber();
              //}
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

  void updateUserInfo(BuildContext context) async {
    print("enterend registernew user -----------------------------------");
     DatabaseReference refrence = FirebaseDatabase.instance.ref('drivers').child(currentFirebaseUser!.uid);
print(refrence.key);

refrence.child('name').set(_nameTextController.text);
refrence.child('phone').set(_phoneTextController.text);

     // await refrence.set({
     //   "name" : _nameTextController.text,
     //   "phone" : _phoneTextController.text,
     //
     // });

  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
