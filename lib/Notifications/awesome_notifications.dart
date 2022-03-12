import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> newRideRequestNotification() async{
  
  await AwesomeNotifications().createNotification(
      content: NotificationContent(id: createUniqueID(5), channelKey: 'basic_channel',
      title: 'New Ride Request Notification',
      body: 'Open Your Rio Driver App For More Information',
      notificationLayout: NotificationLayout.Default));
}

int createUniqueID(int num){
  var random = Random();
  int radNumber = random.nextInt(num);
  return radNumber.toInt();
}