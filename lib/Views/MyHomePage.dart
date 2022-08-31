import 'dart:async';

import 'package:dustbin_app/Utils/auth.dart';
import 'package:dustbin_app/Views/FirstTab.dart';
import 'package:dustbin_app/Views/FourthTab.dart';
import 'package:dustbin_app/Views/LoginOrSignUp.dart';
import 'package:dustbin_app/Views/SecondTab.dart';
import 'package:dustbin_app/Views/ThirdTab.dart';
import 'package:dustbin_app/Views/cardView/AddNewPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const snackBarDuration = Duration(seconds: 3);
  final snackBar = SnackBar(
    content: Text('Press Back Again To Exit'),
    duration: snackBarDuration,
  );

  DateTime backButtonPressTime;

  int _currentTab = 0;

  FirstTab firstTab;
  SecondTab secondTab;
  ThirdTab thirdTab;
  FourthTab fourthTab;

  List<Widget> pages;
  Widget currentPage;

  final _btnController = new RoundedLoadingButtonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstTab = FirstTab();
    secondTab = SecondTab();
    thirdTab = ThirdTab();
    fourthTab = FourthTab();

    pages = [firstTab,secondTab,thirdTab,fourthTab];
    currentPage = firstTab;
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null || currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return true;
  }

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
        length: pages.length,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: Container(
                child: AppBar(
                  actions: [

                    SizedBox(width: 10,),

                    Container(
                      width: 45,
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset("assets/images/main_icon.jpg"),
                    ),

                    Spacer(),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Traffic Via", style: TextStyle(fontSize: 18, color: Colors.orange,fontFamily: 'Montserrat-SemiBold'),),
                      ],
                    ),

                    Spacer(),

                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 5),
                        child: Icon(Icons.menu, color: Colors.black, size: 30,),
                      ),
                      onTap: () {

                        _scaffoldKey.currentState.openEndDrawer();

                      },
                    ),
                    SizedBox(width: 10,)
                  ],
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.grey[100],
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.home,size: 25,color: Colors.blue,),
                      ),
                      Tab(
                        icon: Icon(Icons.calendar_today,size: 20,color: Colors.black45,),
                      ),
                      Tab(
                        icon: Icon(Icons.notifications_active,size: 25,color: Colors.black45,),
                      ),
                      Tab(
                        icon: Icon(Icons.settings,size: 25,color: Colors.black45,),
                      ),
                    ],
                  ),
                ),
              )
          ),

          body: WillPopScope(
            onWillPop: onWillPop,
            child: TabBarView(
              children: pages,
            ),
          ),

          endDrawer: SafeArea(
            child: Container(
              width: screenSize.width-screenSize.width/4,
              child: Drawer(
                child: Scrollbar(
                  child: new Column(
                    children: <Widget>[

                      SizedBox(height: 10,),

                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(right: 3*MediaQuery.of(context).size.width/8),
                            width: 3*MediaQuery.of(context).size.width/8,
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_back_ios, size: 18,color: Colors.grey[600],),
                                Text("Dashboard", style: TextStyle(fontSize: 15, color: Colors.grey[600], fontFamily: 'Montserrat-SemiBold'),),

                              ],
                            )
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),

                      Container(
                        alignment: Alignment.center,
                        height: screenSize.width/2,
                        child: Image.asset("assets/images/main_icon.jpg"),
                      ),

                      Spacer(),

                      InkWell(
                        onTap: () {

                          Navigator.of(context).pop();

                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('Profile',
                              style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {

                          Navigator.of(context).pop();

                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('Points',
                              style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {

                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewPost()));

                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('Add New Post',
                              style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
                          ),
                        ),
                      ),

                      Spacer(),
                      Spacer(),

                      Container(
                        height: 35,
                        width: screenSize.width/2.4,
                        margin: EdgeInsets.only(top: 7),
                        child: RoundedLoadingButton(
                          color: Colors.black,
                          successColor: Colors.black,
                          valueColor: Colors.white,
                          child: Text('Sign Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Montserrat-Bold',
                            ),
                          ),
                          controller: _btnController,
                          onPressed: () {

                            _btnController.stop();
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
                                        signOut();
                                      },
                                    ),
                                  ],
                                )
                            );

                          },
                        ),
                      ),

                      SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
            ),
          ),

        )
    );
  }
  void signOut() {

    AuthService().signOut().then((result) {

      if(result != 'null') {

        if(result == 'success') {

          _btnController.success();
          Timer(Duration(milliseconds: 150), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginOrSignUp()));
          });

        }
      } else {

        _btnController.stop();
        Fluttertoast.showToast(
            msg: "Error.!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    });
  }
}