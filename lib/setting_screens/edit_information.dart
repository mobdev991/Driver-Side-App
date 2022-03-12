import 'package:flutter/material.dart';
import 'package:riorider/widgets/edit_info_form.dart';
import '../screens/login.dart';
import '../widgets/signup_form.dart';

import '../theme.dart';

class EditInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      'Edit Information',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: kDefaultPadding,
                child: EditInfoForm(),
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
