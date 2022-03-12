import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage("images/third_pic.jpg"),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Abdullah',
                style: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Driver', style: TextStyle(color: Colors.indigo))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Today'),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 78,
                        width: 190,
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(14),
                                topLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Hi jake, how are you? I saw on jungle that we have Dragonfly in common'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 78,
                        width: 190,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(14),
                                topLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Hi jake, how are you? I saw on jungle that we have Dragonfly in common'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(14),
                                topLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Sure, lets do it!'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 78,
                        width: 190,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(14),
                                topLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Hi jake, how are you? I saw on jungle that we have Dragonfly in common'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo),
                              borderRadius: BorderRadius.circular(14),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.send,
                          size: 35,
                          color: Colors.indigo,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
