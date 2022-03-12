import 'package:flutter/material.dart';

class TotalFareAmount extends StatefulWidget {
  const TotalFareAmount({Key? key}) : super(key: key);

  @override
  _TotalFareAmountState createState() => _TotalFareAmountState();
}

class _TotalFareAmountState extends State<TotalFareAmount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 90,
                  child: Image.asset('images/Rio Logo.png'),
                ),
                Text(
                  'Wed,Nov22,2022',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text(
                  'Thanks for Leading the ride!',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trip Fare',
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold)),
                Text('Rs 130',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text('Details',
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Row(
              children: [
                Text('Sales Tax',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Row(
              children: [
                Text('VAT 5%',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Row(
              children: [
                Text('Rio Fee',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Row(
              children: [
                Text('Promo Code',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal :',
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold)),
                Text('Rs 360',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount :',
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold)),
                Text('Rs 400',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Earning :',
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold)),
                Text('Rs 230',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => FarePage()));
                    },
                    child: Text(
                      'Complete Trip',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => FarePage()));
                    },
                    child: Text(
                      'Report Issue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
