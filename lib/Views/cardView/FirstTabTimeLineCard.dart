//import 'package:dustbin_app/Models/HomeTimeLine.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class FirstTabTimeLineCard extends StatefulWidget {
//  final HomeTimeLine homeTimeLine;
//  final DatabaseReference databaseReference;
//  FirstTabTimeLineCard(this.homeTimeLine, this.databaseReference);
//
//  @override
//  _FirstTabTimeLineCardState createState() {
//    return _FirstTabTimeLineCardState(homeTimeLine,databaseReference);
//  }
//}
//
//class _FirstTabTimeLineCardState extends State<FirstTabTimeLineCard> {
//  HomeTimeLine homeTimeLine;
//  DatabaseReference databaseReference;
//  _FirstTabTimeLineCardState(this.homeTimeLine, this.databaseReference);
//
//  String message = "Please Wait...!";
//
//  @override
//  Widget build(BuildContext context) {
//
//    var screenSize = MediaQuery.of(context).size;
//
//    return Container(
//      margin: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 5),
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.all(Radius.circular(10)),
//          color: Colors.white,
//          boxShadow: [
//            BoxShadow(
//                color: Colors.blueGrey[400],
//                blurRadius: 10
//            )
//          ]
//      ),
//      child: Column(
//        children: [
//
//          SizedBox(height: 10,),
//
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: [
//              Container(
//                  margin: EdgeInsets.only(left: 10, right: 15),
//                  child: Container(
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(35)),
//                        color: Colors.white,
//                        boxShadow: [
//                          BoxShadow(
//                              color: Colors.blueGrey[400],
//                              blurRadius: 10
//                          )
//                        ]
//                    ),
//                    child: CircleAvatar(
//                      radius: 35,
//                      backgroundColor: Colors.transparent,
//                      backgroundImage: homeTimeLine.image_url != null ? NetworkImage("https://care-bank-nemo.s3-us-east-2.amazonaws.com/${homeTimeLine.image_url}") : AssetImage('assets/icons/default_icon.png'),
//                    ),
//                  )
//              ),
//              Container(
//                width: screenSize.width-115,
//                margin: EdgeInsets.only(top: 10, bottom: 10),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text("${homeTimeLine.service_category}",
//                      overflow: TextOverflow.ellipsis,
//                      maxLines: 1,
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 16,
//                        fontFamily: 'Montserrat-SemiBold',
//                      ),),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: [
//                        Icon(Icons.place,color: Colors.blue, size: 20,),
//                        Container(
//                          width: screenSize.width-135,
//                          child: Text("Road 1, City",
//                              overflow: TextOverflow.ellipsis,
//                              maxLines: 1,
//                              style: TextStyle(
//                                color: Colors.grey[600],
//                                fontSize: 12,
//                                fontFamily: 'Montserrat-SemiBold',
//                              )),
//                        ),
//                      ],
//                    ),
//
//                    Container(
//                      width: screenSize.width-135,
//                      child: Text(" £  ${homeTimeLine.hourly_rate} / Hour",
//                          overflow: TextOverflow.ellipsis,
//                          maxLines: 1,
//                          style: TextStyle(
//                            color: Colors.blue,
//                            fontSize: 14,
//                            fontFamily: 'Montserrat-Bold',
//                          )),
//                    ),
//
//                    Text("Starts At : ${homeTimeLine.job_start_at}",
//                        overflow: TextOverflow.ellipsis,
//                        maxLines: 1,
//                        style: TextStyle(
//                          color: Colors.grey[600],
//                          fontSize: 12,
//                          fontFamily: 'Montserrat-SemiBold',
//                        )
//                    ),
//
//                    Text("End At : ${homeTimeLine.job_end_at}",
//                        overflow: TextOverflow.ellipsis,
//                        maxLines: 1,
//                        style: TextStyle(
//                          color: Colors.grey[600],
//                          fontSize: 12,
//                          fontFamily: 'Montserrat-SemiBold',
//                        )
//                    ),
//                  ],
//                ),
//              )
//            ],
//          ),
//
//          SizedBox(height: 10,),
//
//          Row(
//            children: [
//
//              Spacer(),
//
//              Container(
//                height: 30,
//                width: screenSize.width/2.4,
//                decoration: BoxDecoration(
//                    color: Colors.blue,
//                    borderRadius: BorderRadius.all(Radius.circular(50))
//                ),
//                child: Center(
//                  child: Text('Accept Job',
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 14,
//                      fontFamily: 'Montserrat-SemiBold',
//                    ),
//                  ),
//                ),
//              ),
//
//              Spacer(),
//
//              Container(
//                height: 30,
//                width: screenSize.width/2.4,
//                decoration: BoxDecoration(
//                    color: Colors.black,
//                    borderRadius: BorderRadius.all(Radius.circular(50))
//                ),
//                child: Center(
//                  child: Text('Detail View',
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 14,
//                      fontFamily: 'Montserrat-SemiBold',
//                    ),
//                  ),
//                ),
//              ),
//
//              Spacer(),
//
//            ],
//          ),
//          SizedBox(height: 15,)
//        ],
//      ),
//    );
//  }
//}
