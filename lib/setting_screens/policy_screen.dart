import 'package:flutter/material.dart';

class AppPrivacy extends StatefulWidget {
  const AppPrivacy({Key? key}) : super(key: key);

  @override
  _AppPrivacyState createState() => _AppPrivacyState();
}

class _AppPrivacyState extends State<AppPrivacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('App Privacy'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'The App Privacy section includes '
                'information about the types of data that may'
                'be collected by the developer or its'
                'third-party partners during normal app'
                'usage, but it may not describe all the'
                'developer\'s practices. The data collected'
                'from you may also vary from what is'
                'displayed in this section. For example,'
                'collected data may depend on the features'
                'you use, on whether you only use a paid'
                'version of an app or on whether you are a'
                'child.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                  'In addition, developers are not required to'
                  'list data in this section when the data'
                  'collected meets all the following criteria:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• You provide the data to the app directly in'
                  'the app\'s user interface.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• Your name or account name clearly'
                  'appears alongside the data you submit.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• The data submission is optional, meaning'
                  'you are not required to provide the data in'
                  'order for the app to function.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• You affirmatively choose to provide the'
                  'data each time it is collected.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• The data collection occurs only in'
                  'infrequent cases that are not part of the app\'s primary functionality.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• The data is only used for app functionality,'
                  'personalisation or analytics, and not to track'
                  'you across apps or websites or to show you'
                  'advertisements.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  'For certain apps that facilitate regulated'
                  'financial services or health research,'
                  'developers may choose to not list data in'
                  'the App Privacy section under the following'
                  'circumstances:'
                  'The data is collected by an app that-facilitates regulated financial services, and:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• Collection of the regulated data from you'
                  'is optional and occurs only in cases that are'
                  'not part of the app\'s primary functionality.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• The data collected from you is covered by'
                  'a privacy notice under the relevant financial'
                  'services or data protection laws or'
                  'requlations.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• The privacy notice provides that our data'
                  'is not shared with unaffiliated third parties to'
                  'market other products and services to you.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                  '• Your data is not linked with third-party'
                  'data for advertising purposes or shared '
                  'a data broker, except for fraud purposes or'
                  'when the data broker is a consumer'
                  'reporting agency and the data is shared for'
                  'credit reporting purposes.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 15,
              ),
              Text(
                  'The data collected from you is subject to an'
                  'informed consent form to which you have'
                  'agreed as part of a health research study'
                  'that has been reviewed and approved by an'
                  'institutional review board or ethics review'
                  'board, and is not used to track you across'
                  'apps or websites.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text(
                  'This section also excludes information about'
                  'the data collected by the device\'s operating'
                  'system, to which developers do not have'
                  'access. The data collected in these cases is'
                  'presented to you in separate disclosures'
                  'when you set up your Apple ID, your devices'
                  'and other Apple services.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text(
                  'For more information about the data'
                  'collected by the developer and how it is'
                  'used, see the developer\'s privacy policy.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
