import 'package:dustbin_app/Views/Login.dart';
import 'package:dustbin_app/Views/SignupUser.dart';
import 'package:flutter/material.dart';

class LoginOrSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[

            Spacer(),

            Container(
              height: 160,
              padding: EdgeInsets.only(top: 10,left: 30, right: 30,),
              child: Image.asset("assets/images/main_icon.jpg"),
            ),

            Spacer(),


            InkWell(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(50),
                    )
                ),
                child: Center(
                  child: Text('Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Montserrat-SemiBold',
                    ),
                  ),
                ),
              ),
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));

              },
            ),

            SizedBox(height: 20,),

            Text('Or',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Montserrat-SemiBold',
              ),
            ),

            SizedBox(height: 20,),

            InkWell(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)
                    )
                ),
                child: Center(
                  child: Text('Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Montserrat-SemiBold',
                    ),
                  ),
                ),
              ),
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupUser()));

              },
            ),

            Spacer(),

          ],
        ),
      ),
    );
  }
}