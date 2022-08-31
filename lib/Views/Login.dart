import 'dart:async';

import 'package:dustbin_app/Utils/auth.dart';
import 'package:dustbin_app/Utils/cons.dart';
import 'package:dustbin_app/Views/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool passwordVisible = true;

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _btnController = new RoundedLoadingButtonController();

  var checkBoxValue = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Container(
            child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                leading: InkWell(
                  child: Container(
                    child: Icon(
                      Icons.arrow_back_ios, color: Colors.grey[600], size: 20,),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
            ),
          )
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Colors.white,
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: screenSize.width,
              minHeight: screenSize.height,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[

                    Container(
                      height: 160,
                      padding: EdgeInsets.only(top: 10,left: 30, right: 30,),
                      child: Image.asset("assets/images/main_icon.jpg"),
                    ),

                    Spacer(),

                    Container(
                      width: screenSize.width/1.3,
                      padding: EdgeInsets.only(left: 17, right: 16, bottom: 4),
                      child: Text("Username or E-mail",
                          style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: (screenSize.width-(screenSize.width/1.3))/2),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.grey[600]),
                          border: InputBorder.none,
                          fillColor: Colors.white, filled: true,
                          errorStyle: TextStyle(color: Colors.red[900]),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(width: 1.5,color: Colors.deepPurple),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(width: 1.5,color: Colors.black)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(width: 1.5,color: Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(width: 1.5,color: Colors.black)
                          ),
                          contentPadding: EdgeInsets.only(bottom: 3, left: 16),
                        ),
                        validator: validateEmail,
                      ),
                    ),

                    Container(
                      width: screenSize.width/1.3,
                      padding: EdgeInsets.only(top: 15, left: 17, bottom: 4),
                      child: Text("Password",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: (screenSize.width-(screenSize.width/1.3))/2),
                      child: TextFormField(
                        controller: _passwordController,
                          style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                        autofocus: false,
                        autocorrect: false,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          hintText: "*************",
                          hintStyle: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.grey[600]),
                          border: InputBorder.none,
                          fillColor: Colors.white, filled: true,
                          errorStyle: TextStyle(color: Colors.red[900]),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(width: 1.5,color: Colors.deepPurple),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(width: 1.5,color: Colors.black)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(width: 1.5,color: Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(width: 1.5,color: Colors.black)
                          ),

                          contentPadding: EdgeInsets.only(bottom: 3, left: 16),
                        ),
                          validator: validatePassword
                      ),
                    ),

                    Spacer(),

                    Text('Forgot Password?',
                      style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 14),),

                    SizedBox(height: 10,),

                    Container(
                      height: 45,
                      width: screenSize.width/1.3,
                      child: Center(
                        child: RoundedLoadingButton(
                          color: Colors.deepPurple,
                          successColor: Colors.deepPurple,
                          valueColor: Color(0xffD7C176),

                          child: Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Montserrat-SemiBold',
                            ),
                          ),
                          controller: _btnController,
                          onPressed: () {

                            onLogin();
                          },
                        ),
                      ),
                    ),

                    Spacer(),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  void onLogin() {

    AuthService().login(_emailController.text,_passwordController.text).then((result) async {

      if(result != 'null') {

        if(result == 'success') {

          print(Constance.userID);

          _btnController.success();
          Timer(Duration(milliseconds: 150), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          });

        }
      } else {

        _btnController.stop();
        Fluttertoast.showToast(
            msg: "Login Failed.!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }).catchError((e){
      _btnController.stop();
      print(e);
    });
  }
}

String validateEmail(String value) {
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);

  if (value.isEmpty)
    return 'This field is required';
  else if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String validatePassword(String value) {
//    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return 'This field is required';
  } else {
    if (!regex.hasMatch(value))
      return 'Enter valid password';
    else
      return null;
  }
}

String validateText(String value) {

  if(value.isEmpty) {
    return "This field is required";
  }
  return null;
}

String validateNumber(String value) {

  Pattern pattern = '[0-9]';
  RegExp regex = new RegExp(pattern);

  if (value.isEmpty)
    return 'This field is required';
  else if (!regex.hasMatch(value))
    return 'Enter numbers only';
  else
    return null;
}

String mobileNumberValidate(String value) {
  Pattern pattern = r'^(?:7|0|(?:\+94))[0-9]{9,10}$';
  RegExp regex = new RegExp(pattern);

  if (value.isEmpty)
    return 'This field is required';
  else if (!regex.hasMatch(value))
    return 'Enter valid number';
  else
    return null;
}

String noValidate(String value) {

    return null;
}

