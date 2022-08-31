import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogs {

  void noInternetConnection(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("No Internet Connection",style: TextStyle(fontFamily: 'Montserrat-Bold',),),
          content: new Text("You are offline. Please check your internet connection",style: TextStyle(fontFamily: 'Montserrat-SemiBold',),),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("OK",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
  }

  void signOutMessage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: new Text("Are You Sure You Want To Sign Out?" ,style: TextStyle(fontFamily: 'Montserrat-SemiBold',),),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Cancel",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Sign Out",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
  }

  void enableLocation(context,message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Enable Location",style: TextStyle(fontFamily: 'Montserrat-Bold',),),
          content: new Text("$message" ,style: TextStyle(fontFamily: 'Montserrat-SemiBold',),),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Done",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
  }

  void distanceError(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
//          title: new Text("Enable Location",style: TextStyle(fontFamily: 'Montserrat-Bold',),),
          content: new Text("You Are Not Close Enaough To Open Garbage Bin Door. Maximum You Can Have 10m Distance From Garbage Bin" ,style: TextStyle(fontFamily: 'Montserrat-SemiBold',),),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Done",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
  }

  void showForgetPasswordAlert(context) {
    showDialog(
        context: context, builder: (_) => CupertinoAlertDialog(
//          title: new Text("Alert.!",style: TextStyle(fontFamily: 'Montserrat-Bold',),),
      content: new Text("You Will Receive An E-Mail. Use It To Change Your Password" ,style: TextStyle(fontFamily: 'Montserrat-SemiBold'),),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("Done",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
          onPressed: () {

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    ));
  }
}

final AlertDialogs alertDialog = AlertDialogs();