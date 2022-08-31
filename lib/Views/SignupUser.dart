import 'dart:async';

import 'package:dustbin_app/Utils/auth.dart';
import 'package:dustbin_app/Views/Login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignupUser extends StatefulWidget {
  SignupUser();

  @override
  _SignupUserState createState() {
    return _SignupUserState();
  }
}

class _SignupUserState extends State<SignupUser> {
  _SignupUserState();

  List<Widget>list = new List();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _vehicleNumberController = TextEditingController();

  final _btnController = new RoundedLoadingButtonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
        height: screenSize.height,
        width: screenSize.width,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              
              Text("Signup", style: TextStyle(fontFamily: 'Montserrat-SemiBold',fontSize: 50, color: Colors.black),),

              SizedBox(height: 20,),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                child: Text("Your Name",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter Your Name',
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
                  validator: validateText,
                ),
              ),

              SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                child: Text("E-mail",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: TextFormField(
                  controller: _emailController,
                   
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter E-mail',
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

              Column(
                children: [

                  SizedBox(height: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                    child: Text("Confirm E-mail",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Re Enter E-mail',
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
                      validator: validateReEmail,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Column(
                children: [
                  SizedBox(height: 30,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                    child: Text("Set Password",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: TextFormField(
                        controller: _passwordController,
                        style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                        autofocus: false,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
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
                        validator: validatePassword,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                      child: Text(
                        'One or more upper case\n'
                            'One or more lower case\n'
                            'One or more numbers\n'
                            'At least 8 characters',
                        style: TextStyle(fontSize: 11.0, color: Colors.green[900],fontFamily: 'Montserrat-Medium',fontWeight: FontWeight.bold),
                      )),

                  SizedBox(height: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                    child: Text("Confirm Password",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: TextFormField(
                        style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                        autofocus: false,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Re Type Password",
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
                        validator: (str) {

                          if(str.length == 0) {

                            return "This field is required";

                          } else if(str != _passwordController.text){

                            return "Password does not match";
                          }
                          return null;
                        }
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30,),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                child: Text("Phone Number",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile Number',
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
                  validator: mobileNumberValidate,
                ),
              ),

              SizedBox(height: 30,),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                child: Text("Vehicle Number",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: TextFormField(
                  controller: _vehicleNumberController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {

                        });
                      },
                    ),
                    hintText: 'Enter Vehicle Number',
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
                  validator: validateText,
                ),
              ),

              SizedBox(height: 20,),

              Container(
                height: 45,
                width: screenSize.width/1.3,
                child: Center(
                  child: RoundedLoadingButton(
                    color: Colors.deepPurple,
                    successColor: Colors.deepPurple,
                    valueColor: Color(0xffD7C176),

                    child: Text('SignUp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Montserrat-SemiBold',
                      ),
                    ),
                    controller: _btnController,
                    onPressed: () {

                      var form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();

                        registerUser();

                      } else {

                        _btnController.stop();
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }

  void registerUser() {

    AuthService().register(_emailController.text, _passwordController.text, _nameController.text, _phoneNumberController.text,_vehicleNumberController.text).then((result) async {

      if(result != 'null') {

        if(result == 'success') {

          _btnController.success();
          Timer(Duration(milliseconds: 150), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
          });

        }

      } else {

        _btnController.stop();
        Fluttertoast.showToast(
            msg: "Register Failed.!",
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

  String validateReEmail(String value) {

    if (value.isEmpty)
      return 'This field is required';
    else if (_emailController.text != value)
      return 'E-mail does not match';
    else
      return null;
  }
}