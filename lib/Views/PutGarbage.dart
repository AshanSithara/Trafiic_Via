import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:dustbin_app/Utils/auth.dart';
import 'package:dustbin_app/Utils/cons.dart';
import 'package:dustbin_app/Utils/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class PutGarbage extends StatefulWidget {
  final String dustBinKey;
  final String dustBinID;
  final double lat;
  final double lon;
  PutGarbage(this.dustBinKey,this.dustBinID,this.lat,this.lon);

  @override
  _PutGarbageState createState() => _PutGarbageState(dustBinKey,dustBinID,lat,lon);
}

class _PutGarbageState extends State<PutGarbage> {
  String dustBinKey;
  String dustBinID;
  double lat;
  double lon;
  _PutGarbageState(this.dustBinKey,this.dustBinID,this.lat,this.lon);

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Container(
            child: AppBar(
              actions: [

                SizedBox(width: 10,),

                Container(
                  height: 40,
                  width: 40,
                ),

                Spacer(),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Smart Trash", style: TextStyle(fontSize: 14, color: Colors.deepPurple,fontFamily: 'Montserrat-SemiBold'),),
                    Text("Garbage Bin", style: TextStyle(fontSize: 18, color: Colors.black,fontFamily: 'Montserrat-SemiBold'),),
                  ],
                ),

                Spacer(),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset("assets/images/main_icon.jpg",height: 50, width: 50,),
                ),

                SizedBox(width: 10,)
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.grey[100],
            ),
          )
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            InkWell(
              child: Container(
                alignment: Alignment.center,
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10),

                    )
                ),
                child: Column(
                  children: [
                    Icon(Icons.qr_code,size: 150,),
                    Text("Scan QR For Open Dustbin Door",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Montserrat-SemiBold'),
                    )
                  ],
                ),
              ),
              onTap: () async {

                showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
//          title: new Text("Enable Location",style: TextStyle(fontFamily: 'Montserrat-Bold',),),
                      content: new Text("Please Wait.! Calculating Distance Between You And Garbage Bin" ,style: TextStyle(fontFamily: 'Montserrat-SemiBold',),),
                      actions: <Widget>[
                      ],
                    )
                );

                double distanceFilter = 0.2;
                double startLatitude;
                double startLongitude;
//                String newDistance;

                await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((currloc) {

                  startLatitude = currloc.latitude;
                  startLongitude = currloc.longitude;

                  print("geoLocator lat: $startLatitude");
                  print("geoLocator long: $startLongitude");

                  Navigator.of(context).pop();

                  Geolocator().distanceBetween(startLatitude, startLongitude, lat, lon).then((value) async {

                    print("Distance in meter out: ${value/1000}");

                    if (value / 1000 < distanceFilter) {
                      double distance = value / 1000;
//                    newDistance = distance.toString().split('.').first;

                      print("Distance in meter in: $distance");

                      ScanResult codeScanner = await BarcodeScanner.scan();

                      if(dustBinID == codeScanner.rawContent.toString()) {

                        AuthService().doorOpen(dustBinKey,dustBinID).then((value) {

                          Fluttertoast.showToast(
                              msg: "Door Open. Input your Garbage Within 10 Seconds",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                        });

                      } else {

                        Fluttertoast.showToast(
                            msg: "Scan Failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }

                    } else {

                      alertDialog.distanceError(context);

                    }
                  });

                }).catchError((error){
                  print(error);
                });

              },
            )


          ],
        ),

      ),
    );
  }
}
