import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../Phase_one/loginoption_page.dart';
import '../screens/login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
              bodyWidget: Center(
                child: Text(
                  "Drive Your Favoirte Ride\nand Earn Money",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.indigo, fontSize: 20, shadows: [
                    Shadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(1, 1),
                    )
                  ]),
                ),
              ),
              image: Image.asset("images/second_pic.jpeg"),
              // footer: Text(
              //   "Your Favorite Ride",
              //   style: TextStyle(
              //     color: Colors.indigo,
              //     fontSize: 20,
              //   ),
              // ),
              titleWidget: Text(
                "FAVORITE RIDE",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold),
              )),
          PageViewModel(
            titleWidget: Text("Low Commission Rates",
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            bodyWidget: Center(
              child: Text(
                "Our Low Commission Rates\nEnables You To\nEarn More Money ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.indigo, fontSize: 20, shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(1, 1),
                  )
                ]),
              ),
            ),
            image: Image.asset(
              "images/comission.png",
              width: double.infinity,
            ),
            // footer: Text(
            //   "Wait time of no more than 5 minutes",
            //   style: TextStyle(
            //     color: Colors.indigo,
            //     fontSize: 20,
            //   ),
            // ),
          ),
          PageViewModel(
              titleWidget: Text("Support Team",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              bodyWidget: Center(
                child: Text(
                  "Our Support Team Is There\nTo Help You Solve\nAny Problems",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.indigo, fontSize: 20, shadows: [
                    Shadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(1, 1),
                    )
                  ]),
                ),
              ),
              image: Image.asset("images/support.png")),
        ],
        onDone: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogInScreen()));
          print("Done is clicked");
        },
        showSkipButton: true,
        showNextButton: true,
        nextFlex: 1,
        dotsFlex: 2,
        skipFlex: 1,
        animationDuration: 1000,
        curve: Curves.fastOutSlowIn,
        dotsDecorator: DotsDecorator(
            spacing: EdgeInsets.all(5),
            color: Colors.indigo,
            // activeSize: Size.square(10),
            // size: Size.square(5),
            activeSize: Size(20, 10),
            size: Size.square(10),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        skip: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(4, 4))
              ]),
          child: Center(
            child: Text(
              "Skip",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        next: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.indigo, width: 2)),
          child: Center(
            child: Icon(
              Icons.navigate_next,
              size: 30,
              color: Colors.indigo,
            ),
          ),
        ),
        done: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 40,
                    offset: Offset(4, 4))
              ]),
          child: Center(
            child: Text(
              "Done",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ));
  }
}
