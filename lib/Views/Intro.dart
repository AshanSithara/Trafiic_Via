import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dustbin_app/Views/LoginOrSignUp.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: screenSize.height,
                      child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image(
                              image: AssetImage('assets/images/st1.jpg',),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40, bottom: 40),
                            child: Image(
                              image: AssetImage('assets/images/st2.jpg',),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40, bottom: 40),
                            child: Image(
                              image: AssetImage('assets/images/st3.jpg',),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Image(
                              image: AssetImage('assets/images/st4.jpg',),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            top: (screenSize.height-50)/2,
            right: -5,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomLeft: Radius.circular(35)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey[400],
                          blurRadius: 10
                      )
                    ]
                ),
                height: 50,
                width: 40,
                child: InkWell(
                  child: Icon(Icons.play_arrow, size: 30,color: Colors.orange,),
                  onTap: () async {

                    if(_currentPage != _numPages - 1) {

                      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn,);

                    } else {

                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('seenBefore', true);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginOrSignUp()));

                    }

                  },
                )),
          )
        ],
      ),
    );
  }
}
