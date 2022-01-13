import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class Users {
  String? id;
  String? email;
  String? phone;
  String? name;

  Users({this.id, this.email, this.phone, this.name});

  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key!;

    var data = dataSnapshot.value as Map?;

    if (data != null) {
      email = data?["email"];
      name = data?["name"];
      phone = data?["phone"];
    }
  }
}
