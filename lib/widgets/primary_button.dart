import 'package:flutter/material.dart';

import '../theme.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  Function onTap;
  PrimaryButton({required this.buttonText, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.indigo,
            minimumSize: Size(200, 40),
            padding: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.indigo)),
          ),
          onPressed: () {
            onTap();
          },
          child: Text(buttonText),
        );
  }
}
