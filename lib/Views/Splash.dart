import 'dart:async';
import 'package:dustbin_app/Utils/cons.dart';
import 'package:dustbin_app/Utils/dialogs.dart';
import 'package:dustbin_app/Views/Intro.dart';
import 'package:dustbin_app/Views/LoginOrSignUp.dart';
import 'package:dustbin_app/Views/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  initState() {
    // TODO: implement initState

    Future.delayed(Duration(
      seconds: 4,
    ), () async {

      final prefs = await SharedPreferences.getInstance();
      final userID = prefs.getString('user_id') ?? 'null';

      Constance.userID = userID;

      final myBool = prefs.getBool('seenBefore') ?? false;

      await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).timeout(const Duration(seconds: 30)).then((currloc) {

        Constance.currentLatitude = currloc.latitude;
        Constance.currentLongitude = currloc.longitude;

        print("geoLocator lat: ${Constance.currentLatitude.toString()}");
        print("geoLocator long: ${Constance.currentLongitude.toString()}");

      }).catchError((error){
        print(error);
      });

      if(Constance.currentLatitude == 0 || Constance.currentLongitude == 0) {
        alertDialog.enableLocation(context, "Failed to automatically switch on loation service. Further services will not appear without location service. Please switch on it");
      }

      if(myBool == true) {

        if(userID != 'null') {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));

        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginOrSignUp()));
        }

      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Intro()));
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          children: [
            Spacer(),

            Container(
              height: screenSize.height/2,
              margin: EdgeInsets.only(bottom: 40),
              child: Image.asset("assets/images/main_icon.jpg"),
            ),
            Text("Welcome",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 40, color: Colors.black),),
            Spacer()
          ],
        ),
      ),
    );
  }
}
