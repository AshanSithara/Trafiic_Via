import 'dart:async';
import 'dart:io';

import 'package:dustbin_app/Utils/auth.dart';
import 'package:dustbin_app/Views/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddNewPost extends StatefulWidget {
  @override
  _AddNewPostState createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  File _image;
  String proPic;

  final _descriptionController = TextEditingController();
  final _btnController = new RoundedLoadingButtonController();

  void getImage(source) async {

    File image = await ImagePicker.pickImage(source: source);
    if(image != null){
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.orange,
            toolbarTitle: "Scale the image",
            statusBarColor: Colors.orange,
            backgroundColor: Colors.white,
          )
      );

      this.setState((){
        _image = cropped;
      });
    }
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
            child: ListView(
              children: [

                Container(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 30),
                          width: MediaQuery.of(context).size.width/1.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Upload Post", style: TextStyle(fontSize: 35, color: Colors.black, fontFamily: 'Montserrat-Bold'),),

                            ],
                          )
                      ),

                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: screenSize.width/1.3,
                            padding: EdgeInsets.only(bottom: 4),
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(90)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.blueGrey[400],
                                        blurRadius: 30
                                    )
                                  ]
                              ),
                              child: CircleAvatar(
                                radius: 90,
                                backgroundColor: Colors.transparent,
                                backgroundImage: _image == null ? proPic != null ? NetworkImage(proPic) : AssetImage('assets/icons/default_icon.png') : FileImage(_image),
                              ),
                            )),
                        onTap: () {

                          showDialogCameraAndGallery1(context);
                        },
                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                        child: Text("Enter Post Description",style: TextStyle(color: Colors.black,fontFamily: 'Montserrat-SemiBold',fontSize: 15)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: TextFormField(
                          maxLength: 500,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _descriptionController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Enter Post',
                            hintStyle: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 15,color: Colors.grey[600]),
                            border: InputBorder.none,
                            fillColor: Colors.white, filled: true,
                            errorStyle: TextStyle(color: Colors.red[900]),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(width: 1.5,color: Colors.deepPurple),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(width: 1.5,color: Colors.black)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(width: 1.5,color: Colors.black),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(width: 1.5,color: Colors.black)
                            ),
                            contentPadding: EdgeInsets.only(bottom: 3, left: 16),
                          ),
                          validator: validateText,
                        ),
                      ),

                      SizedBox(height: 20,),

                      _image != null ? Container(
                        height: 40,
                        width: screenSize.width/1.8,
                        child: Center(
                          child: RoundedLoadingButton(
                            color: Colors.deepPurple,
                            successColor: Colors.deepPurple,
                            valueColor: Color(0xffD7C176),

                            child: Text('Upload Post',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Montserrat-SemiBold',
                              ),
                            ),
                            controller: _btnController,
                            onPressed: () {

                              uploadPost();
                            },
                          ),
                        ),
                      ) : Container(),

                      SizedBox(height: 30,),
                    ],
                  ),
                )

              ],
            )
        )
    );
  }

  void showDialogCameraAndGallery(context) {

    showCupertinoModalPopup(context: context, builder: (context) {

      return CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nova',
                ))
        ),
        actions: <Widget>[

          CupertinoActionSheetAction(
            onPressed: () {

              getImage(ImageSource.gallery);
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.image,
                  color: Color.fromRGBO(209, 93, 44, 1),
                ),
                SizedBox(width: 5,),
                Text("Gallery",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nova',
                    ))
              ],
            ),
          ),

          CupertinoActionSheetAction(
            onPressed: () {

              getImage(ImageSource.camera);
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.camera_alt,
                  color: Color.fromRGBO(209, 93, 44, 1),
                ),
                SizedBox(width: 5,),
                Text("Camera",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nova',
                    ))
              ],
            ),
          )
        ],
      );
    });

  }

  void showDialogCameraAndGallery1(context) {

      var screenSize = MediaQuery.of(context).size;

      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: new Text("Select Type"),
            content: new Container(
              height: screenSize.height/8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(height: 7),
                      Expanded(
                        child: GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.image,
                                color: Color.fromRGBO(209, 93, 44, 1),
                              ),
                              SizedBox(width: 5,),
                              Text("Gallery",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nova',
                                  ))
                            ],
                          ),
                          onTap: (){

                            getImage(ImageSource.gallery);
                            Navigator.pop(context);

                          },
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      SizedBox(height: 7),
                      Expanded(
                        child: GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.camera_alt,
                                color: Color.fromRGBO(209, 93, 44, 1),
                              ),
                              SizedBox(width: 5,),
                              Text("Camera",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nova',
                                  ))
                            ],
                          ),
                          onTap: (){

                            getImage(ImageSource.camera);
                            Navigator.pop(context);

                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Cancel",style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat-SemiBold',)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
      );
    }

  void uploadPost() {

    AuthService().uploadPost(_descriptionController.text,_image).then((result) async {

      if(result != 'null') {

        if(result == 'success') {

          _btnController.success();
          Timer(Duration(milliseconds: 150), () {
            Navigator.of(context).pop();
          });

        }

      } else {

        _btnController.stop();
        Fluttertoast.showToast(
            msg: "Upload Failed.!",
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
