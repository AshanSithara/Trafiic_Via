import 'package:dustbin_app/Utils/auth.dart';
import 'package:dustbin_app/Views/cardView/FirstTabTimeLineCard1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab>{
  DatabaseReference databaseReference;
  String message = "Please Wait...!";

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.reference().child("socialmedia-project").child("timeline").child("posts");
    databaseReference.keepSynced(true).asStream();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
        future: AuthService().getMyTimeLineData(databaseReference),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color(0xffD7C176)),
                    )));
          } else {
            Future.delayed(Duration(
              seconds: 1,
            ), () async {
              setState(() {});
            });

            return snapshot.data.length != 0 ? Container(
                height: screenSize.height - 285,

                ///bottom nav 80px + app bar 55px
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, cardIndex) {
                    return FirstTabTimeLineCard1(
                        snapshot.data[cardIndex], databaseReference);
                  },
                )
            ) : Container(
              alignment: Alignment.center,
              child: Text(
                  'You Have Not Post Before',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat-Bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            );
          }
        }
    );
  }
}