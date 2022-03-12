import 'package:flutter/material.dart';
import 'package:riorider/Assistance/assistanceMethods.dart';
import 'package:riorider/Models/history.dart';

class HistoryItem extends StatelessWidget {
  final History history;
  HistoryItem({required this.history});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trip Date/Time',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AssistantMethods.formatTripDate(history.createdAt!),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PickUp Location',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold,),
                      ),
                      Text(
                        history.pickUp!.substring(0,30),style: TextStyle(fontSize: 12
                      ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Destination Location',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        history.dropOff!.substring(0,30),style: TextStyle(fontSize:12
                      ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trip Cost',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'RS ${history.fares}',
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
