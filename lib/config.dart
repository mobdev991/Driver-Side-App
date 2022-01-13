import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riorider/Models/drivers.dart';

import 'Models/allUsers.dart';

User? firebaseUser;

Users? userCurrentInfo;

User? currentFirebaseUser;

StreamSubscription<Position>? homeTabPageStreamSubscription;

StreamSubscription<Position>? rideStreamSubscription;

final assetsAudioPlayer = AssetsAudioPlayer();

Position? currentPosition;

Drivers? driversInformation;
