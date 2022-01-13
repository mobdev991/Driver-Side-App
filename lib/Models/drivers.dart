import 'package:firebase_database/firebase_database.dart';

class Drivers {
  String? name;
  String? phone;
  String? email;
  String? id;
  String? car_model;
  String? car_color;
  String? car_number;

  Drivers(
      {this.id,
      this.phone,
      this.name,
      this.email,
      this.car_model,
      this.car_color,
      this.car_number});

  Drivers.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;

    var data = dataSnapshot.value as Map?;
    print(' datasnapshot of driverss ::');
    print(dataSnapshot.value);

    if (data != null) {
      phone = data["phone"];
      email = data["email"];
      name = data["name"];
      car_model = data["car_details"]["car_model"];
      car_color = data["car_details"]["car_color"];
      car_number = data["car_details"]["car_number"];
    }
  }
}
