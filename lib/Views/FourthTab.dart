import 'package:dustbin_app/Models/UserData.dart';
import 'package:dustbin_app/Utils/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FourthTab extends StatefulWidget {
  @override
  _FourthTabState createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
  DatabaseReference databaseReference;
  String message = "Please Wait...!";

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.reference().child("socialmedia-project").child("users");
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
        future: AuthService().getMyProfileData(databaseReference),
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

            return Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/1.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(height: 15,),

                        Text("Profile", style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: 'Montserrat-Bold'),),

                      ],
                    )
                ),

                Container(
                    width: screenSize.width/1.3,
                    padding: EdgeInsets.only(bottom: 4),
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueGrey[400],
                                blurRadius: 30
                            )
                          ]
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
//                        backgroundImage: (snapshot.data as UserData).image != null ? NetworkImage((snapshot.data as UserData).image) : AssetImage('assets/icons/default_icon.png'),
                        backgroundImage: AssetImage('assets/images/default_icon.png'),
                      ),
                    )),

                Container(
                    width: screenSize.width-60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (screenSize.width-60)/3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Name :  ",style: TextStyle(fontSize: 14, color: Colors.grey[500], fontFamily: 'Montserrat-SemiBold'),),
                              SizedBox(height: 10,),

                              Text("E-mail :  ",style: TextStyle(fontSize: 14, color: Colors.grey[500], fontFamily: 'Montserrat-SemiBold'),),
                              SizedBox(height: 10,),

                              Text("Tel No :  ",style: TextStyle(fontSize: 14, color: Colors.grey[500], fontFamily: 'Montserrat-SemiBold'),),
                              SizedBox(height: 10,),

                              Text("V.Number :  ",style: TextStyle(fontSize: 14, color: Colors.grey[500], fontFamily: 'Montserrat-SemiBold'),),
                            ],
                          ),
                        ),
                        Container(
                          width: 2*(screenSize.width-60)/3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text("${(snapshot.data as UserData).user_name}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Montserrat-SemiBold'),),
                              SizedBox(height: 10,),

                              Text("${(snapshot.data as UserData).email}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Montserrat-SemiBold'),),
                              SizedBox(height: 10,),

                              Text("${(snapshot.data as UserData).phone_number}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Montserrat-SemiBold'),),
                              SizedBox(height: 10,),

                              Text("${(snapshot.data as UserData).vehicle_number}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Montserrat-SemiBold'),),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 30,),
              ],
            );
          }
        }
    );
  }
}