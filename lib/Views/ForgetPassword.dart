import 'package:dustbin_app/Utils/auth.dart';
import 'package:dustbin_app/Utils/dialogs.dart';
import 'package:dustbin_app/Views/Login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _btnController = new RoundedLoadingButtonController();

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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
//        margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,left: 30, right: 30),
            color: Colors.white,
            height: screenSize.height-80,
            width: screenSize.width,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: screenSize.width,
                  minHeight: screenSize.height-80,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        SizedBox(height: 25,),

                        Container(
                            width: screenSize.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Forgot Password", style: TextStyle(fontFamily: 'Montserrat-SemiBold',fontSize: 30, color: Colors.black),),
                              ],
                            )
                        ),

                        SizedBox(height: 20,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 18, right: 16, bottom: 4),
                          child: Text("Enter E-Mail",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Enter E-Mail That You Registered',
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

                        Spacer(),

                        Container(
                          height: 45,
                          width: screenSize.width/1.3,
                          child: Center(
                            child: RoundedLoadingButton(
                              color: Colors.deepPurple,
                              successColor: Colors.deepPurple,
                              valueColor: Color(0xffD7C176),

                              child: Text('Send E-Mail',
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

                                  forgetPassword(context);
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
              ),
            ),
          ),
        )
    );
  }

  void forgetPassword(context) {

    AuthService().forgetPassword(_emailController.text).then((result) async {

      if(result != 'null') {

        if(result == 'success') {

          _btnController.stop();
          alertDialog.showForgetPasswordAlert(context);

        } else{

          _btnController.stop();
          Fluttertoast.showToast(
              msg: "Error. Something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

        }
      } else {

        _btnController.stop();
        Fluttertoast.showToast(
            msg: "Error. Something went wrong",
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
