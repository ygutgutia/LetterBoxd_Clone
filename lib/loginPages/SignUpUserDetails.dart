import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../apis/authentication_service.dart';

import '../themes.dart';

class SignUpDetails extends StatefulWidget {  
  @override
  _SignUpDetailsClass createState() => _SignUpDetailsClass();
}

class _SignUpDetailsClass extends State<SignUpDetails> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name, username, phNo, dob, photoLink;
  bool isUserLoading = false;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign Up Details'),
      ),

      body: Center(
        child: GestureDetector(

        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },

        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) {
                          name = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your Name',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) {
                          username = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your Username',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: TextFormField(
                        obscureText: true,
                        onSaved: (String value) {
                            phNo = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your phone Number',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your ph no';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: TextFormField(
                        obscureText: true,
                        onSaved: (String value) {
                            dob = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your dob',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your dob';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: TextFormField(
                        obscureText: true,
                        onSaved: (String value) {
                            photoLink = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your photoLink(temp enter anythin)',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your photoLink';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 13.0,),

                    isUserLoading ? CircularProgressIndicator() : ElevatedButton(
                      child: Text('Save Details'),
                      onPressed: () {
                        _formKey.currentState.save();
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isUserLoading = true;
                          });
                          saveDetails();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),);
  }

  void saveDetails() async {

    String returnMsg = await context.read<AuthenticationService>().setUserDetails(name, username, phNo, dob, photoLink);
    String toastMsg = "Profile Updated";
    if(returnMsg!="Success"){
      toastMsg = returnMsg;
    }

    setState(() {
      isUserLoading = false;  
    });
    Fluttertoast.showToast(
      msg: toastMsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: elevatedButtonPrimaryColor2,
      textColor: hintTextColor,
      fontSize: 16.0
    );

    
    if(returnMsg=="Success"){
      Navigator.pushReplacementNamed(context, '/loginpage');
    }
  }
}

