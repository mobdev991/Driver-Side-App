import 'package:flutter/material.dart';

import 'loginoption_page.dart';
class carasol extends StatefulWidget {
  const carasol({Key? key}) : super(key: key);

  @override
  _carasolState createState() => _carasolState();
}

class _carasolState extends State<carasol> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Container(
                height: 120,
                width: 120,
                //height: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/Rio Logo.png")

                    )
                ),
              ),

              Column(
                children:<Widget> [
                  MaterialButton(
                    color: Colors.indigo,
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> loginoption()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.indigo,
                      ),
                     // borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "I am a driver",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,color: Colors.white,
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> loginoption()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.blue,
                      ),
                     // borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "I am a pessenger",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,color: Colors.black,
                      ),

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
