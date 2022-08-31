import 'package:dustbin_app/Models/HomeTimeLine.dart';
import 'package:dustbin_app/Utils/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstTabTimeLineCard1 extends StatefulWidget {
  final HomeTimeLine homeTimeLine;
  final DatabaseReference databaseReference;
  FirstTabTimeLineCard1(this.homeTimeLine, this.databaseReference);

  @override
  _FirstTabTimeLineCard1State createState() {
    return _FirstTabTimeLineCard1State(homeTimeLine,databaseReference);
  }
}

class _FirstTabTimeLineCard1State extends State<FirstTabTimeLineCard1> {
  HomeTimeLine homeTimeLine;
  DatabaseReference databaseReference;

  _FirstTabTimeLineCard1State(this.homeTimeLine, this.databaseReference);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            "${homeTimeLine.postOwnerImageUrl}"),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${homeTimeLine.postOwnerName}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text('${homeTimeLine.time}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.0,
                                  ),
                                ),
                                Icon(
                                  Icons.public,
                                  color: Colors.grey[600],
                                  size: 12.0,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.more_horiz),
                        onPressed: () => print('More'),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text("${homeTimeLine.description}"),
                  SizedBox(height: 6.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Image.network("${homeTimeLine.imageUrl}"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          size: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Expanded(
                        child: Text('${homeTimeLine.likesCount}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Text(
                        '${homeTimeLine.commentCount} Comments',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              height: 25.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: homeTimeLine.liked == "1" ? Colors.blue : Colors.grey[600],
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text("Like", style: TextStyle(fontSize: 12),),
                                ],
                              ),
                            ),
                            onTap: () {

                              if(homeTimeLine.liked == "1") {

                                removeLike();
                              } else {

                                addLike();
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              height: 25.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.comment,
                                    color: Colors.grey[600],
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    "Comment", style: TextStyle(fontSize: 12),),
                                ],
                              ),
                            ),
                            onTap: () => print('Comment'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              height: 25.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey[600],
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text("Location",
                                    style: TextStyle(fontSize: 12),),
                                ],
                              ),
                            ),
                            onTap: () => print('Show Location'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addLike() {

    AuthService().addLike(homeTimeLine.postOwnerUserID, homeTimeLine.key);

  }

  void removeLike() {

    AuthService().removeLike(homeTimeLine.postOwnerUserID, homeTimeLine.key);
  }
}