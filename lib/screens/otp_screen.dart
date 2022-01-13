import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/Home_page.dart';

enum Status { Waiting, Error }

class Otp extends StatefulWidget {
  const Otp({Key? key, required this.number}) : super(key: key);
  final number;
  @override
  _OtpState createState() => _OtpState(number);
}

class _OtpState extends State<Otp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _optEditingController = TextEditingController();
  final phoneNumber;
  var _status = Status.Waiting;
  var _verificationId;
  _OtpState(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'images/Rio Logo.png',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _optEditingController,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(),
                      textAlign: TextAlign.center,
                      style: TextStyle(letterSpacing: 30, fontSize: 30),
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                    ),
                    // _textFieldOTP(
                    //   first: true,
                    //   last: false,
                    // ),
                    // _textFieldOTP(first: false, last: false),
                    // _textFieldOTP(first: false, last: false),
                    // _textFieldOTP(first: false, last: true),

                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _verifyPhoneNumber();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Home(),
                          //     ));
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.indigo),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async => _verifyPhoneNumber(),
                child: Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _textFieldOTP({bool? first, last}) {
  //   return Container(
  //     height: 55,
  //     child: AspectRatio(
  //       aspectRatio: 1.0,
  //       child: TextField(
  //         // controller: _optEditingController,
  //         autofocus: true,
  //         onChanged: (value) {
  //           if (value.length == 1 && last == false) {
  //             FocusScope.of(context).nextFocus();
  //             //   codeString = '${codeString}  ${value';
  //           }
  //           if (value.length == 0 && first == false) {
  //             FocusScope.of(context).previousFocus();
  //           }
  //         },
  //         showCursor: false,
  //         readOnly: false,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         keyboardType: TextInputType.number,
  //         maxLength: 1,
  //         decoration: InputDecoration(
  //           counter: const Offstage(),
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(width: 2, color: Colors.black12),
  //               borderRadius: BorderRadius.circular(12)),
  //           focusedBorder: OutlineInputBorder(
  //               borderSide: BorderSide(width: 2, color: Colors.indigo),
  //               borderRadius: BorderRadius.circular(12)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("VerificationComplete is executing");
          _sendCodeToFirebase(code: _optEditingController.text);
          print('${phoneNumber}');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        verificationFailed: (verificationFailed) async {
          print("VerificationFailed is executing");
        },
        codeSent: (verificationId, resendingToken) async {
          print("Codesent is executing");
          setState(() {
            this._verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print("codetimeout is executing");
        });
  }

  Future _sendCodeToFirebase({String? code}) async {
    if (this._verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);
      _auth.currentUser?.linkWithCredential(credential);

      // await _auth
      //     .signInWithCredential(credential)
      //     .then((value) {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => Home()));
      //     })
      //     .whenComplete(() {})
      //     .onError((error, stackTrace) {
      //       setState(() {
      //         _optEditingController.text = "";
      //         this._status = Status.Error;
      //       });
      //     });
    }
  }
// verifyPhoneCode(otp, code) async {
  //   final AuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: _optEditingController.text,
  //     smsCode: val,
  //   );
  //   currentUser.linkWithCredential(credential);
  // }
}
