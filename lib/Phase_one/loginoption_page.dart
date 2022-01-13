import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../screens/signup.dart';

class loginoption extends StatefulWidget {
  const loginoption({Key? key}) : super(key: key);

  @override
  _loginoptionState createState() => _loginoptionState();
}
class _loginoptionState extends State<loginoption> {
  final List<String> imgList = [
    'https://www.uber-assets.com/image/upload/f_auto,q_auto:eco,c_fill,w_1082,h_811/v1613521742/assets/bd/95fdef-9d4d-41f8-a3ec-9f3500454bd3/original/Rider_Home_bg_mobile.png',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
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
                SizedBox(
                  height: 100,
                ),
                CarouselSlider(
                  items: imgList
                      .map((item) => Container(

                    child: Center(
                      child: Image.network(

                        item,
                       fit: BoxFit.cover,
                      //  height: 5000,
                        width: 1800,
                      ),
                    ),
                  ))
                      .toList(),
                  options: CarouselOptions(

                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                ),
                       SizedBox(
                         height: 100,
                       ),
                //CarouselWithDotsPage(imgList: imgList),
                Column(
                  children:<Widget> [
                    MaterialButton(
                      color: Colors.indigo,
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.indigo,
                        ),
                        // borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Create Account",
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  LogInScreen()));
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.blue,
                        ),
                        // borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Login to Your Acoount",
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
      ),
    );
  }
}
