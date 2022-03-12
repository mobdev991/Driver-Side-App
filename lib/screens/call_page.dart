import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 100,
                left: 50,
                right: 50,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('images/third_pic.jpg'),
                )),
            Positioned(
                top: 200,
                left: 130,
                child: Text(
                  'Cihan soysakal',
                  style: TextStyle(color: Colors.white),
                )),
            Positioned(
                top: 230,
                left: 155,
                child: Text(
                  'Ringing',
                  style: TextStyle(color: Colors.grey),
                )),
            Positioned(
                top: 530,
                left: 110,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.record_voice_over_rounded,
                    color: Colors.indigo,
                  ),
                )),
            Positioned(
                top: 530,
                left: 200,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PaymentPage()));
                    },
                    icon: Icon(
                      Icons.call_end,
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
