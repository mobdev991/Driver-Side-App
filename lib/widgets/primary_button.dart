import 'package:flutter/material.dart';

import '../theme.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  Function onTap;
  PrimaryButton({required this.buttonText, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.indigo),
        child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          child: Text(buttonText),
        ));
  }
}
