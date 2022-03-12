import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riorider/setting_screens/aboutUs_screen.dart';
import 'package:riorider/setting_screens/policy_screen.dart';
import '../setting_screens/account_settings.dart';
import 'online_support.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 70,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 40, bottom: 18, left: 12, right: 12),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountSetting()));
                        },
                        child: Text(
                          'Account Setting',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUs()));
                        },
                        child: Text(
                          'About Us',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: TextButton(
                        onPressed: () {
                          _showMyDialog(context);
                        },
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppPrivacy()));
                        },
                        child: Text(
                          'Terms & Conditions',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppPrivacy()));
                        },
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'App Version',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Beta 01.00.01',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Contact us',
            style: TextStyle(color: Colors.grey),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.indigo,
                      ),
                      label: Text(
                        'WhatsApp:03207172727',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(),
                    TextButton.icon(
                      icon: FaIcon(FontAwesomeIcons.mailBulk,
                          color: Colors.indigo),
                      label: Text(
                        'Email Address:contact@heyrio.co',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(),
                    TextButton.icon(
                      icon:
                          FaIcon(FontAwesomeIcons.weebly, color: Colors.indigo),
                      label: Text(
                        'Website:http://heyrio.co',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(),
                    TextButton.icon(
                      icon: FaIcon(FontAwesomeIcons.facebook,
                          color: Colors.indigo),
                      label: Text(
                        'Facebook page: https://www.facebook.com/heyrio.co/',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(),
                    TextButton.icon(
                      icon: FaIcon(FontAwesomeIcons.instagram,
                          color: Colors.indigo),
                      label: Text(
                        'Instagram: heyrio.co',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(),
                    TextButton.icon(
                      icon: FaIcon(FontAwesomeIcons.addressCard,
                          color: Colors.indigo),
                      label: Text(
                        'Street address: Valencia town, Lahore, Punjab, Pakistan-54100',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('Approve'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}
