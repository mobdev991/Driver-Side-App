import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riorider/config.dart';
import 'package:riorider/screens/Home_page.dart';

import 'chat_widgets/chat_room_item.dart';
import 'chat_widgets/custom_dialog.dart';
import 'chat_widgets/custom_textfield.dart';
import 'service_message.dart';
import 'model/message.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  MessageService service = MessageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: Column(
          children: [
            Text("Chat Room"),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Connected ${rideDetailsGlobal!.rider_name}',
              style: TextStyle(
                  color: Colors.indigo.shade400,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 10), child: getChats()),
          ),
        ],
      ),
      floatingActionButton: getBottom(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  getChats() {
    return StreamBuilder<QuerySnapshot>(
        stream: service.getMessageStream(10),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          var data = snapshot.data!.docs;
          print(data.length);
          return ListView.builder(
              itemBuilder: (context, index) {
                var msg = Message.fromJson(
                    data[index].data() as Map<String, dynamic>);
                return ChatRoomItem(message: msg);
              },
              shrinkWrap: true,
              itemCount: data.length);
        });
  }

  getBottom() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 5),
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Container(
                child: CustomTextField(
              controller: messageController,
              hintText: "Write your message",
            )),
          ),
          IconButton(
              onPressed: () {
                sendMessage();
              },
              icon: Icon(
                Icons.send_rounded,
                color: isLoading ? Colors.grey : Colors.indigo,
                size: 35,
              ))
        ],
      ),
    );
  }

  sendMessage() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    var res = await service.sendMessage(messageController.text);

    setState(() {
      isLoading = false;
    });
    if (res["status"] == true) {
      messageController.clear();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Chat",
              descriptions: res["message"],
            );
          });
    }
  }
}
