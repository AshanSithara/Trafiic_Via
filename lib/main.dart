import 'package:dustbin_app/Views/Intro.dart';
import 'package:dustbin_app/Views/Login.dart';
import 'package:dustbin_app/Views/LoginOrSignUp.dart';
import 'package:dustbin_app/Views/MyHomePage.dart';
import 'package:dustbin_app/Views/SignupUser.dart';
import 'package:dustbin_app/Views/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp (
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        title: 'App Name',
        home: Splash(),
        routes: <String, WidgetBuilder>{
          '/splash': (BuildContext context) => new Splash(),
          '/intro': (BuildContext context) => new Intro(),
          '/loginOrSignUp': (BuildContext context) => new LoginOrSignUp(),
          '/login': (BuildContext context) => new Login(),
          '/myHomePage': (BuildContext context) => new MyHomePage(),
          '/signUpUser': (BuildContext context) => new SignupUser(),
        }),
  );
}