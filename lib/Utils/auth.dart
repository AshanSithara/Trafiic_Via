import 'dart:async';
import 'dart:io';
import 'package:dustbin_app/Models/DustbinLocations.dart';
import 'package:dustbin_app/Models/HomeTimeLine.dart';
import 'package:dustbin_app/Models/UserData.dart';
import 'package:dustbin_app/Utils/cons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  Future<String> login(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    String status = 'null';

    final User user = (await auth.signInWithEmailAndPassword(
        email: email, password: password)).user;

    if (user != null) {
      status = 'success';
      Constance.userID = user.uid;
      print(user.uid);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', "${Constance.userID}");
    }

    return status;
  }

  Future<String> register(String email, String password, String name,
      String phnNum, String vNumber) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference().child("socialmedia-project").child("users");

    String status = 'null';

    final User user = (await auth.createUserWithEmailAndPassword(
        email: email, password: password)).user;

    if (user != null) {
      status = 'success';

      DatabaseReference newDatabaseReference = databaseReference.child(
          "${user.uid}");

      newDatabaseReference.child("user_id").set(user.uid);
      newDatabaseReference.child("user_name").set(name);
      newDatabaseReference.child("email").set(email);
      newDatabaseReference.child("phone_number").set(phnNum);
      newDatabaseReference.child("vehicle_number").set(vNumber);
    }

    return status;
  }

  Future<String> forgetPassword(String email) async {
    String status = 'null';

    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.sendPasswordResetEmail(email: email).then((value) {
      status = 'success';
    });

    return status;
  }

  Future<List<DustbinLocations>> getDustbinLocations(
      DatabaseReference databaseReference) async {
    List<DustbinLocations> newDustbinLocations = [];

    await databaseReference.once().then((DataSnapshot dataSnapshot) async {
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {
        DustbinLocations dustbinLocations = new DustbinLocations(
          values[key]["id"],
          key,
          values[key]["latitude"],
          values[key]["longitude"],
        );
        newDustbinLocations.add(dustbinLocations);
      }
    });

    return newDustbinLocations;
  }

  Future<String> signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    String status = 'null';

    await auth.signOut().then((value) async {
      final prefs = await SharedPreferences.getInstance();
      Constance.userID = 'null';
      await prefs.remove('user_id');
      status = 'success';
    });

    return status;
  }

  Future<void> doorOpen(String dustBinKey, String dustbinID) async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference().child("garbage-project").child("garbage-collection");

    DatabaseReference newDatabaseReference = databaseReference.child(
        "$dustbinID");

    newDatabaseReference.child("dustbinID").set(dustbinID);
    newDatabaseReference.child("door_open").set(1);
    newDatabaseReference.child("userID").set(Constance.userID);


    Timer _timer;
    int _start = 10;

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) {
      if (_start < 1) {
        timer.cancel();
        newDatabaseReference.child("door_open").set(0);
        _timer.cancel();
        _start = 999999;
      } else {
        _start = _start - 1;
        print("tiktok: $_start");
      }
    },
    );
  }

  Future<List<HomeTimeLine>> getHomeTimeLineData(DatabaseReference databaseReference) async {

    List<HomeTimeLine> newTimeLine = [];

    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {

        String liked = "0";
//        Map likedList = values[key]["likedusers"] as Map;
//
//        for(int i = 0; i < likedList.length; i++) {
//          if (likedList.values.contains(Constance.userID)) {
//
//            liked = "1";
//
//          } else {
//
//            liked = "0";
//          }
//        }

        HomeTimeLine homeTimeLine = new HomeTimeLine(
            values[key]["commentCount"],
            values[key]["description"],
            values[key]["imageUrl"],
            key,
            values[key]["latitude"],
            values[key]["longitude"],
            values[key]["likesCount"],
            values[key]["postOwnerImageUrl"],
            values[key]["postOwnerUserID"],
            values[key]["time"],
            values[key]["postOwnerName"],
            liked
        );
        newTimeLine.add(homeTimeLine);
      }
    });
    return newTimeLine;
  }

  Future<List<HomeTimeLine>> getMyTimeLineData(DatabaseReference databaseReference) async {
    List<HomeTimeLine> newTimeLine = [];

    await databaseReference.orderByChild("postOwnerUserID").equalTo(Constance.userID).once().then((DataSnapshot dataSnapshot) {
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {

        String liked = "0";
//        Map likedList = values[key]["likedusers"] as Map;
//
//        for(int i = 0; i < likedList.length; i++) {
//          if (likedList.values.contains(Constance.userID)) {
//
//            liked = "1";
//
//          } else {
//
//            liked = "0";
//          }
//        }

        HomeTimeLine homeTimeLine = new HomeTimeLine(
            values[key]["commentCount"],
            values[key]["description"],
            values[key]["imageUrl"],
            key,
            values[key]["latitude"],
            values[key]["longitude"],
            values[key]["likesCount"],
            values[key]["postOwnerImageUrl"],
            values[key]["postOwnerUserID"],
            values[key]["time"],
            values[key]["postOwnerName"],
            liked
        );
        newTimeLine.add(homeTimeLine);
      }
    });
    return newTimeLine;
  }

  Future<UserData> getMyProfileData(DatabaseReference databaseReference) async {

    UserData newUserData;

    await databaseReference.child(Constance.userID).once().then((DataSnapshot dataSnapshot) {

      var values = dataSnapshot.value;

      newUserData = new UserData(
        values["user_name"],
        values["email"],
        values["phone_number"],
        values["vehicle_number"],
        values["user_id"],
      );

    });
    return newUserData;
  }

  Future<bool> addLike(userID, postID) async {

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("socialmedia-project").child("timeline").child("posts");

    await databaseReference.child(postID).child("likedusers").child(userID).set(userID);
  }

  Future<bool> removeLike(userID, postID) async {

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("socialmedia-project").child("timeline").child("posts");

    await databaseReference.child(postID).child("likedusers").child(userID).remove();
  }

  Future<String> uploadPost(String description, File _imageFile) async {

    String status = 'null';

    DatabaseReference postDataReference = FirebaseDatabase.instance.reference().child("socialmedia-project").child("timeline").child("posts").push();
    DatabaseReference userDataReference = FirebaseDatabase.instance.reference().child("socialmedia-project").child("users");

    final _firebaseStorage = FirebaseStorage.instance;

    var snapshot = await _firebaseStorage.ref().child('images/imageName').putFile(_imageFile);

    String downloadUrl = await snapshot.ref.getDownloadURL();

    await userDataReference.child(Constance.userID).once().then((DataSnapshot dataSnapshot) {

      var values = dataSnapshot.value;

      String userName = values["user_name"];
      DateTime now = DateTime.now();
      String time = "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}";

      postDataReference.child("postOwnerUserID").set(Constance.userID);
      postDataReference.child("key").set(postDataReference.key);
      postDataReference.child("postOwnerImageUrl").set("");
      postDataReference.child("postOwnerName").set(userName);
      postDataReference.child("description").set(description);
      postDataReference.child("time").set(time);
      postDataReference.child("imageUrl").set(downloadUrl);
      postDataReference.child("likesCount").set("0");
      postDataReference.child("commentCount").set("0");
      postDataReference.child("latitude").set(Constance.currentLatitude);
      postDataReference.child("longitude").set(Constance.currentLongitude);
      postDataReference.child("longitude").child("likedusers").child(Constance.userID).set(Constance.userID);

      status = 'success';

    });

    return status;
  }
}

final AuthService authService = AuthService();
