//import 'dart:async';
//
//import 'package:dustbin_app/Utils/auth.dart';
//import 'package:dustbin_app/Utils/cons.dart';
//import 'package:dustbin_app/Utils/mapView.dart';
//import 'package:dustbin_app/Views/LoginOrSignUp.dart';
//import 'package:dustbin_app/Views/PutGarbage.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:rounded_loading_button/rounded_loading_button.dart';
//
//class MyHomePage extends StatefulWidget {
//  final double distanceFilter;
//  MyHomePage(this.distanceFilter);
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState(this.distanceFilter);
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  double distanceFilter;
//  _MyHomePageState(this.distanceFilter);
//
//  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//  static const snackBarDuration = Duration(seconds: 3);
//  final snackBar = SnackBar(
//    content: Text('Press Back Again To Exit'),
//    duration: snackBarDuration,
//  );
//
//  DateTime backButtonPressTime;
//
//  Future<bool> onWillPop() async {
//    DateTime currentTime = DateTime.now();
//
//    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
//        backButtonPressTime == null || currentTime.difference(backButtonPressTime) > snackBarDuration;
//
//    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
//      backButtonPressTime = currentTime;
//      _scaffoldKey.currentState.showSnackBar(snackBar);
//      return false;
//    }
//    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//    return true;
//  }
//
//  DatabaseReference databaseReference;
//
//  final _btnController = new RoundedLoadingButtonController();
//
//  Completer<GoogleMapController> _controller = Completer();
//
////  Set<Polyline> polyline = {};
////  List<LatLng> routeCords = [];
////  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: "AIzaSyDvHodPzc3sRgNQUkBzAgF1CtPLKyp9y4Q");
//
//  static const LatLng _center = const LatLng(7.8731, 80.7718);
//
//  double lat;
//  double lon;
//  String dustBinID;
//  String dustBinKey;
//
//  final Set<Marker> _markers = {};
//
//  bool showCard = false;
//
//  LatLng _lastMapPosition = _center;
//
//  MapType _currentMapType = MapType.normal;
//
//  _onMapCreated(GoogleMapController controller) {
//
//    _controller.complete(controller);
//
////    setState(() {
////      _controller = controller;
////
////      polyline.add(
////          Polyline(
////              polylineId: PolylineId("route1"),
////              visible: true,
////              points: routeCords,
////              width: 4,
////              color: Colors.black,
////              startCap: Cap.roundCap,
////              endCap: Cap.buttCap,
////      ));
////
////    });
//  }
//
//  _onCameraMove(CameraPosition position) {
//    _lastMapPosition = position.target;
//  }
//
//  _onMapTypeButtonPressed() {
//    setState(() {
//      _currentMapType = _currentMapType == MapType.normal
//          ? MapType.satellite
//          : MapType.normal;
//    });
//  }
//
//  _onAddMarkerButtonPressed() {
//    setState(() {
//      _markers.add(
//        Marker(
//          markerId: MarkerId(_lastMapPosition.toString()),
//          position: _lastMapPosition,
//          infoWindow: InfoWindow(
//            title: 'This is a Title',
//            snippet: 'This is a snippet',
//          ),
//          icon: BitmapDescriptor.defaultMarker,
//        ),
//      );
//    });
//  }
//
////  createPolyLine() async{
////
////    routeCords = await googleMapPolyline.getCoordinatesWithLocation(
////      origin: LatLng(6.6363, 79.9528),
////      destination: LatLng(6.8649, 79.8997),
////      mode: RouteMode.driving,
////    );
////
////    polyline.add(
////        Polyline(
////          polylineId: PolylineId('1'),
////          visible: true,
////          points: routeCords,
////          width: 4,
////          color: Colors.black,
////          startCap: Cap.roundCap,
////          endCap: Cap.buttCap,
////        ));
////  }
//
//  Widget button(Function function, IconData icon) {
//    return SizedBox(
//      height: 40,
//      width: 40,
//      child: FloatingActionButton(
//        heroTag: null,
//        onPressed: function,
//        materialTapTargetSize: MaterialTapTargetSize.padded,
//        backgroundColor: Colors.blue,
//        child: Icon(
//          icon,
//          size: 25.0,
//        ),
//      ),
//    );
//  }
//
//  Widget button1(IconData icon) {
//    return SizedBox(
//      height: 40,
//      width: 40,
//      child: FloatingActionButton(
//        heroTag: null,
//        onPressed: () {
//
////          setState(() {
////
////            createPolyLine();
//            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(10)));
////          });
//
//        },
//        materialTapTargetSize: MaterialTapTargetSize.padded,
//        backgroundColor: Colors.blue,
//        child: Icon(
//          icon,
//          size: 25.0,
//        ),
//      ),
//    );
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//    databaseReference = FirebaseDatabase.instance.reference().child("garbage-project").child("location");
//    databaseReference.keepSynced(true).asStream();
//
//    AuthService().getDustbinLocations(databaseReference).then((value) {
//
//      double startLatitude = Constance.currentLatitude;
//      double startLongitude = Constance.currentLongitude;
//
//      for(int i = 0; i < value.length; i++) {
//
//        double latitude = double.parse(value[i].latitude);
//        double longitude = double.parse(value[i].longitude);
//        String dustbinKey = value[i].key;
//        String dustbinID = value[i].id;
//
//        ///getting distance to location
//        Geolocator().distanceBetween(startLatitude, startLongitude, latitude, longitude).then((value) {
//          if (value / 1000 < distanceFilter) {
//            double distance = value / 1000;
//            String newDistance = distance.toString().split('.').first;
//
//            _markers.add(
//              Marker(
//                  markerId: MarkerId(_lastMapPosition.toString()),
//                  position: LatLng(latitude, longitude),
//                  infoWindow: InfoWindow(
//                    title: '$newDistance KM Away',
//                    snippet: 'This is snippet',
//                  ),
//                  icon: BitmapDescriptor.defaultMarker,
//                  onTap: () {
//
//                    if(distance < 10) {
//
//                      showCard = true;
//                      lat = latitude;
//                      lon = longitude;
//                      dustBinID = dustbinID;
//                      dustBinKey = dustbinKey;
//                    }
//
//                  }
//              ),
//            );
//
//          }
//        });
//      }
//    });
//
////    _markers.add(
////      Marker(
////        markerId: MarkerId(_lastMapPosition.toString()),
////        position: LatLng(6.6363, 79.9528),
////        infoWindow: InfoWindow(
////          title: 'This is a Title',
////          snippet: 'This is a snippet',
////        ),
////        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
////      ),
////    );
////
////    _markers.add(
////      Marker(
////        markerId: MarkerId(_lastMapPosition.toString()),
////        position: LatLng(6.8649, 79.8997),
////        infoWindow: InfoWindow(
////          title: 'This is a Title',
////          snippet: 'This is a snippet',
////        ),
////        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
////
////      ),
////    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    var screenSize = MediaQuery.of(context).size;
//
////    Future.delayed(Duration(
////      seconds: 1,
////    ), () async {
////      setState(() {});
////    });
//
//    return SafeArea(
//      child: Scaffold(
//        key: _scaffoldKey,
//        appBar: PreferredSize(
//            preferredSize: Size.fromHeight(55),
//            child: Container(
//              child: AppBar(
//                actions: [
//
//                  SizedBox(width: 10,),
//
//                  InkWell(
//                    child: Container(
//                      child: Icon(Icons.menu, color: Colors.grey, size: 40,),
//                    ),
//                    onTap: () {
//
//                      _scaffoldKey.currentState.openDrawer();
//
//                    },
//                  ),
//
//                  Spacer(),
//
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: [
//                      Text("Smart Trash", style: TextStyle(fontSize: 14, color: Colors.deepPurple,fontFamily: 'Montserrat-SemiBold'),),
//                      Text("Dashboard", style: TextStyle(fontSize: 18, color: Colors.black,fontFamily: 'Montserrat-SemiBold'),),
//                    ],
//                  ),
//
//                  Spacer(),
//
//                  Container(
//                    margin: EdgeInsets.symmetric(vertical: 10),
//                    child: Image.asset("assets/images/main_icon.jpg",height: 50, width: 50,),
//                  ),
//
//                  SizedBox(width: 10,)
//                ],
//                automaticallyImplyLeading: false,
//                backgroundColor: Colors.grey[100],
//              ),
//            )
//        ),
//        body: WillPopScope(
//          onWillPop: onWillPop,
//          child: FutureBuilder(
//              future: AuthService().getDustbinLocations(databaseReference),
//              builder: (BuildContext context, AsyncSnapshot snapshot) {
//
//                if (snapshot.data == null) {
//                  return Center(
//                      child: Container(
//                          margin: EdgeInsets.symmetric(vertical: 5),
//                          height: 30,
//                          width: 30,
//                          child: CircularProgressIndicator(
//                            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffD7C176)),
//                          )));
//                } else {
//
//                  Future.delayed(Duration(
//                    seconds: 1,
//                  ), () async {
//                    setState(() {});
//                  });
//
//                  return snapshot.data.length != 0 ? Stack(
//                    children: <Widget>[
//                      GoogleMap(
//                        myLocationButtonEnabled: true,
//                        mapToolbarEnabled: true,
//                        myLocationEnabled: true,
//                        zoomGesturesEnabled: true,
//                        zoomControlsEnabled: true,
//                        onMapCreated: _onMapCreated,
////                polylines: polyline,
//                        initialCameraPosition: CameraPosition(
//                          target: LatLng(Constance.currentLatitude, Constance.currentLongitude),
//                          zoom: 7.0,
//                        ),
//                        mapType: _currentMapType,
//                        markers: _markers,
//                        onCameraMove: _onCameraMove,
//                      ),
//                      Positioned(
//                        top: 50,
//                        right: 0.0,
//                        child: Padding(
//                          padding: EdgeInsets.all(10.0),
//                          child: Align(
//                            alignment: Alignment.topRight,
//                            child: Column(
//                              children: <Widget>[
//                                button(_onMapTypeButtonPressed, Icons.map),
//                                SizedBox(
//                                  height: 10.0,
//                                ),
//                                button(_onAddMarkerButtonPressed, Icons.add_location),
//                                SizedBox(
//                                  height: 10.0,
//                                ),
////                              button(_goToPosition1, Icons.location_searching),
//                                button1(Icons.near_me),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//
//                      showCard == true ? Positioned(
//                        top: 0.0,
//                        left: 5.0,
//                        child: Container(
//                          color: Colors.white,
//                          height: 60,
//                          width: screenSize.width-70,
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              InkWell(
//                                child: Container(
//                                  margin: EdgeInsets.only(top: 5,left: 5),
//                                  height: 35,
//                                  width: screenSize.width/3,
//                                  decoration: BoxDecoration(
//                                      border: Border.all(color: Colors.black,width: 2),
//                                      borderRadius: BorderRadius.all(Radius.circular(50),
//
//                                      )
//                                  ),
//                                  child: Center(
//                                    child: Text('Get Direction',
//                                      style: TextStyle(
//                                        color: Colors.black,
//                                        fontSize: 12,
//                                        fontFamily: 'Montserrat-Bold',
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                onTap: () {
//
//                                  mapView(lat.toString(), lon.toString());
//
//                                },
//                              ),
//                              InkWell(
//                                child: Container(
//                                  margin: EdgeInsets.only(top: 5,left: 5),
//                                  height: 35,
//                                  width: screenSize.width/3,
//                                  decoration: BoxDecoration(
//                                      border: Border.all(color: Colors.black,width: 2),
//                                      borderRadius: BorderRadius.all(Radius.circular(50),
//
//                                      )
//                                  ),
//                                  child: Center(
//                                    child: Text('Put Garbage',
//                                      style: TextStyle(
//                                        color: Colors.black,
//                                        fontSize: 12,
//                                        fontFamily: 'Montserrat-Bold',
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                onTap: () {
//
//                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PutGarbage(dustBinKey,dustBinID,lat,lon)));
//
//                                },
//                              )
//                            ],
//                          ),
//                        ),
//                      ) : Container(),
//
//                    ],
//                  ) : Center(
//                    child: Text(
//                        'Please Wait...!',
//                        textAlign: TextAlign.start,
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontFamily: 'Montserrat-Bold',
//                            fontWeight: FontWeight.bold,
//                            fontSize: 18)),
//                  );
//
//                }
//              }
//          ),
//        ),
//        drawer: SafeArea(
//          child: Container(
//            width: screenSize.width-screenSize.width/4,
//            child: Drawer(
//              child: Scrollbar(
//                child: new Column(
//                  children: <Widget>[
//
//                    SizedBox(height: 10,),
//
//                    InkWell(
//                      child: Container(
//                          margin: EdgeInsets.only(right: 3*MediaQuery.of(context).size.width/8),
//                          width: 3*MediaQuery.of(context).size.width/8,
//                          padding: EdgeInsets.only(bottom: 4),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: [
//                              SizedBox(width: 10,),
//                              Icon(Icons.arrow_back_ios, size: 18,color: Colors.grey[600],),
//                              Text("Dashboard", style: TextStyle(fontSize: 15, color: Colors.grey[600], fontFamily: 'Montserrat-SemiBold'),),
//
//                            ],
//                          )
//                      ),
//                      onTap: () {
//                        Navigator.of(context).pop();
//                      },
//                    ),
//
//                    Container(
//                      alignment: Alignment.center,
//                      height: screenSize.width/2,
//                      child: Image.asset("assets/images/main_icon.jpg"),
//                    ),
//
//                    Spacer(),
//
//                    InkWell(
//                      onTap: () {
//
//                        Navigator.of(context).pop();
//
//                      },
//                      child: Container(
//                        alignment: Alignment.center,
//                        height: 30,
//                        child: Text('Profile',
//                            style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
//                        ),
//                      ),
//                    ),
//                    InkWell(
//                      onTap: () {
//
//                        Navigator.of(context).pop();
//
//                      },
//                      child: Container(
//                        alignment: Alignment.center,
//                        height: 30,
//                        child: Text('Points',
//                            style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
//                        ),
//                      ),
//                    ),
//                    InkWell(
//                      onTap: () {
//
//                        Navigator.of(context).pop();
//
//                      },
//                      child: Container(
//                        alignment: Alignment.center,
//                        height: 30,
//                        child: Text('About Us',
//                            style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
//                        ),
//                      ),
//                    ),
//
//                    Spacer(),
//                    Spacer(),
//
//                    Container(
//                      height: 35,
//                      width: screenSize.width/2.4,
//                      margin: EdgeInsets.only(top: 7),
//                      child: RoundedLoadingButton(
//                        color: Colors.black,
//                        successColor: Colors.black,
//                        valueColor: Colors.white,
//                        child: Text('Sign Out',
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 18,
//                            fontFamily: 'Montserrat-Bold',
//                          ),
//                        ),
//                        controller: _btnController,
//                        onPressed: () {
//
//                          _btnController.stop();
//                          showDialog(
//                              context: context,
//                              builder: (BuildContext context) => CupertinoAlertDialog(
//                                content: new Text("Are You Sure You Want To Sign Out?" ,style: TextStyle(fontFamily: 'Montserrat-SemiBold',),),
//                                actions: <Widget>[
//                                  CupertinoDialogAction(
//                                    isDefaultAction: true,
//                                    child: Text("Cancel",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
//                                    onPressed: () {
//
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                  CupertinoDialogAction(
//                                    isDefaultAction: true,
//                                    child: Text("Sign Out",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
//                                    onPressed: () {
//
//                                      Navigator.of(context).pop();
//                                      signOut();
//                                    },
//                                  ),
//                                ],
//                              )
//                          );
//
//                        },
//                      ),
//                    ),
//
//                    SizedBox(height: 10,),
//
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Future<void> _goToPosition1() async {
//    final GoogleMapController controller = await _controller.future;
//
//    Position currentPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//    CameraPosition _position1 = CameraPosition(
////      bearing: 192.833,
//      target: LatLng(currentPosition.latitude, currentPosition.longitude),
////      tilt: 59.440,
//      zoom: 11.0,
//    );
//
//    setState(() {
//      _markers.add(
//        Marker(
//          markerId: MarkerId(_lastMapPosition.toString()),
//          position: LatLng(currentPosition.latitude, currentPosition.longitude),
//          infoWindow: InfoWindow(
//            title: 'This is a Title',
//            snippet: 'This is a snippet',
//          ),
//          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
//
//        ),
//      );
//    });
//
//    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
//  }
//
//  void signOut() {
//
//    AuthService().signOut().then((result) {
//
//      if(result != 'null') {
//
//        if(result == 'success') {
//
//          _btnController.success();
//          Timer(Duration(milliseconds: 150), () {
//            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginOrSignUp()));
//          });
//
//        }
//      } else {
//
//        _btnController.stop();
//        Fluttertoast.showToast(
//            msg: "Error.!",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIos: 1,
//            backgroundColor: Colors.red,
//            textColor: Colors.white,
//            fontSize: 16.0
//        );
//      }
//    });
//  }
//}















//
//import 'dart:async';
//
//import 'package:dustbin_app/Utils/auth.dart';
//import 'package:dustbin_app/Views/FirstTab.dart';
//import 'package:dustbin_app/Views/FourthTab.dart';
//import 'package:dustbin_app/Views/LoginOrSignUp.dart';
//import 'package:dustbin_app/Views/SecondTab.dart';
//import 'package:dustbin_app/Views/ThirdTab.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:rounded_loading_button/rounded_loading_button.dart';
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//
//  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//  static const snackBarDuration = Duration(seconds: 3);
//  final snackBar = SnackBar(
//    content: Text('Press Back Again To Exit'),
//    duration: snackBarDuration,
//  );
//
//  DateTime backButtonPressTime;
//
//  int _currentTab = 0;
//
//  FirstTab firstTab;
//  SecondTab secondTab;
//  ThirdTab thirdTab;
//  FourthTab fourthTab;
//
//  List<Widget> pages;
//  Widget currentPage;
//
//  final _btnController = new RoundedLoadingButtonController();
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//    firstTab = FirstTab();
//    secondTab = SecondTab();
//    thirdTab = ThirdTab();
//    fourthTab = FourthTab();
//
//    pages = [firstTab,secondTab,thirdTab,fourthTab];
//    currentPage = firstTab;
//  }
//
//  Future<bool> onWillPop() async {
//    DateTime currentTime = DateTime.now();
//
//    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
//        backButtonPressTime == null || currentTime.difference(backButtonPressTime) > snackBarDuration;
//
//    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
//      backButtonPressTime = currentTime;
//      _scaffoldKey.currentState.showSnackBar(snackBar);
//      return false;
//    }
//    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//    return true;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    var screenSize = MediaQuery.of(context).size;
//
//    return Scaffold(
//      key: _scaffoldKey,
//      appBar: PreferredSize(
//          preferredSize: Size.fromHeight(55),
//          child: Container(
//            child: AppBar(
//              actions: [
//
//                SizedBox(width: 10,),
//
//                Container(
//                  margin: EdgeInsets.symmetric(vertical: 10),
//                  child: Image.asset("assets/images/main_icon.png"),
//                ),
//
//                Spacer(),
//
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                    Text("Dashboard", style: TextStyle(fontSize: 18, color: Colors.black,fontFamily: 'Montserrat-SemiBold'),),
//                  ],
//                ),
//
//                Spacer(),
//
//                InkWell(
//                  child: Container(
//                    padding: EdgeInsets.only(left: 15, right: 5),
//                    child: Icon(Icons.menu, color: Colors.black, size: 30,),
//                  ),
//                  onTap: () {
//
//                    _scaffoldKey.currentState.openEndDrawer();
//
//                  },
//                ),
//                SizedBox(width: 10,)
//              ],
//              automaticallyImplyLeading: false,
//              backgroundColor: Colors.grey[100],
//            ),
//          )
//      ),
//
//      body: WillPopScope(
//        onWillPop: onWillPop,
//        child: currentPage,
//      ),
//
//      endDrawer: SafeArea(
//        child: Container(
//          width: screenSize.width-screenSize.width/4,
//          child: Drawer(
//            child: Scrollbar(
//              child: new Column(
//                children: <Widget>[
//
//                  SizedBox(height: 10,),
//
//                  InkWell(
//                    child: Container(
//                        margin: EdgeInsets.only(right: 3*MediaQuery.of(context).size.width/8),
//                        width: 3*MediaQuery.of(context).size.width/8,
//                        padding: EdgeInsets.only(bottom: 4),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: [
//                            SizedBox(width: 10,),
//                            Icon(Icons.arrow_back_ios, size: 18,color: Colors.grey[600],),
//                            Text("Dashboard", style: TextStyle(fontSize: 15, color: Colors.grey[600], fontFamily: 'Montserrat-SemiBold'),),
//
//                          ],
//                        )
//                    ),
//                    onTap: () {
//                      Navigator.of(context).pop();
//                    },
//                  ),
//
//                  Container(
//                    alignment: Alignment.center,
//                    height: screenSize.width/2,
//                    child: Image.asset("assets/images/main_icon.jpg"),
//                  ),
//
//                  Spacer(),
//
//                  InkWell(
//                    onTap: () {
//
//                      Navigator.of(context).pop();
//
//                    },
//                    child: Container(
//                      alignment: Alignment.center,
//                      height: 30,
//                      child: Text('Profile',
//                          style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
//                      ),
//                    ),
//                  ),
//                  InkWell(
//                    onTap: () {
//
//                      Navigator.of(context).pop();
//
//                    },
//                    child: Container(
//                      alignment: Alignment.center,
//                      height: 30,
//                      child: Text('Points',
//                          style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
//                      ),
//                    ),
//                  ),
//                  InkWell(
//                    onTap: () {
//
//                      Navigator.of(context).pop();
//
//                    },
//                    child: Container(
//                      alignment: Alignment.center,
//                      height: 30,
//                      child: Text('About Us',
//                          style: TextStyle(fontFamily: 'Montserrat-Bold',fontSize: 15.0,)
//                      ),
//                    ),
//                  ),
//
//                  Spacer(),
//                  Spacer(),
//
//                  Container(
//                    height: 35,
//                    width: screenSize.width/2.4,
//                    margin: EdgeInsets.only(top: 7),
//                    child: RoundedLoadingButton(
//                      color: Colors.black,
//                      successColor: Colors.black,
//                      valueColor: Colors.white,
//                      child: Text('Sign Out',
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 18,
//                          fontFamily: 'Montserrat-Bold',
//                        ),
//                      ),
//                      controller: _btnController,
//                      onPressed: () {
//
//                        _btnController.stop();
//                        showDialog(
//                            context: context,
//                            builder: (BuildContext context) => CupertinoAlertDialog(
//                              content: new Text("Are You Sure You Want To Sign Out?" ,style: TextStyle(fontFamily: 'Montserrat-SemiBold',),),
//                              actions: <Widget>[
//                                CupertinoDialogAction(
//                                  isDefaultAction: true,
//                                  child: Text("Cancel",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
//                                  onPressed: () {
//
//                                    Navigator.of(context).pop();
//                                  },
//                                ),
//                                CupertinoDialogAction(
//                                  isDefaultAction: true,
//                                  child: Text("Sign Out",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
//                                  onPressed: () {
//
//                                    Navigator.of(context).pop();
//                                    signOut();
//                                  },
//                                ),
//                              ],
//                            )
//                        );
//
//                      },
//                    ),
//                  ),
//
//                  SizedBox(height: 10,),
//
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//
//
//
//      bottomNavigationBar: BottomNavigationBar(
//
//          showSelectedLabels: false,
//          showUnselectedLabels: false,
//          elevation: 30,
//          currentIndex: _currentTab,
//          onTap: (index) {
//
//            _currentTab = index;
//            currentPage = pages[index];
//
//          },
//          type: BottomNavigationBarType.fixed,
//          selectedItemColor: Colors.grey,
//          unselectedItemColor: Colors.black,
//
//          items: [
//            BottomNavigationBarItem(
//              icon: Icon(Icons.home),
////                icon: Container(
////                  width: screenSize.height/35,
////                  height: screenSize.height/37,
////                  child: Icon(Icons.home,size: screenSize.height/32,),),
//              title: Text("Home"),
////                backgroundColor: Colors.red
//            ),
//            BottomNavigationBarItem(
//              icon: Container(child: Icon(Icons.calendar_today, size: 20,),),
////                icon: Icon(Icons.calendar_today),
//              title: Text("Calender"),
//            ),
//            BottomNavigationBarItem(
////                  icon: Icon(Icons.notifications, size: screenSize.height/37,),
//                icon: Icon(Icons.update),
//                title: Text("Histry"),
//                backgroundColor: Colors.green
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.settings),
//              title: Text("Profile"),
//            ),
//          ]
//      ),
//    );
//  }
//  void signOut() {
//
//    AuthService().signOut().then((result) {
//
//      if(result != 'null') {
//
//        if(result == 'success') {
//
//          _btnController.success();
//          Timer(Duration(milliseconds: 150), () {
//            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginOrSignUp()));
//          });
//
//        }
//      } else {
//
//        _btnController.stop();
//        Fluttertoast.showToast(
//            msg: "Error.!",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIos: 1,
//            backgroundColor: Colors.red,
//            textColor: Colors.white,
//            fontSize: 16.0
//        );
//      }
//    });
//  }
//}