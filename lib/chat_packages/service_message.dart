import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config.dart';
import '../chat_packages/model/message.dart';

import 'model/message.dart';

class MessageService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late CollectionReference refMessage;

  Future sendMessage(String message) async {
    final newMessage = Message(
      userId: _firebaseAuth.currentUser!.uid,
      userName: _firebaseAuth.currentUser!.displayName ?? "N/A",
      message: message.trim(),
      createdAt: DateTime.now(),
    );

    try {
      refMessage = db.collection(
          rideDetailsGlobal!.ride_request_id!); // build the room .. in wanna build with my requested ride iD
      var res = await refMessage.add(newMessage.toJson());
      print('rideDetailsGlobal :: ' + rideDetailsGlobal!.ride_request_id!);
      print(res);
      return {"status": true, "message": "success"};
    } on FirebaseAuthException catch (e) {
      return {"status": false, "message": e.message.toString()};
    }
  }

  Stream<QuerySnapshot> getMessageStream(int limit) {
    return db
        .collection(rideRequestIDGlobal!)
        // .where('message', isEqualTo: "Hi")
        .orderBy('createdAt')
        // .limit(limit)
        .snapshots();
  }
}
