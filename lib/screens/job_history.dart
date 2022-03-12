import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riorider/providers/appData.dart';
import 'package:riorider/widgets/history_item.dart';

class JobNotifications extends StatefulWidget {
  const JobNotifications({Key? key}) : super(key: key);

  @override
  _JobNotificationsState createState() => _JobNotificationsState();
}

class _JobNotificationsState extends State<JobNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip History'),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, index) {
          return HistoryItem(
              history: Provider.of<AppData>(context, listen: false)
                  .tripHistoryDataList[index]);
        },
        separatorBuilder: (BuildContext context, index) => SizedBox(
          height: 3,
        ),
        itemCount: Provider.of<AppData>(context, listen: false)
            .tripHistoryDataList
            .length,
        padding: EdgeInsets.all(5),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  @override
  void initState() {
    print(Provider.of<AppData>(context, listen: false).tripHistoryDataList);
    print(Provider.of<AppData>(context, listen: false).tripHistoryDataList);
  }
}
