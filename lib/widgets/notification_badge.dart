import 'package:flutter/material.dart';

class NotificationBadege extends StatelessWidget {
  const NotificationBadege({Key? key, required this.totalNotification})
      : super(key: key);
  final int totalNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          '$totalNotification',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
