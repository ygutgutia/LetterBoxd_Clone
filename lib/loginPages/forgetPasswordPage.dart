import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../themes.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPassClass createState() => _ForgetPassClass();
}

class _ForgetPassClass extends State<ForgetPassword> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool mailSent = false;
  String email;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: appBGColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reset Password'),
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
                        style: TextStyle(color: formFieldTextColor),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) {
                          email = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Enter a valid Email Address';
                          }
                          return null;
                        },
                      ),
                    ),

                    ElevatedButton(
                      child: Text('GO'),
                      style: ElevatedButton.styleFrom(
                        primary: elevatedButtonPrimaryColor1,
                        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      onPressed: () {
                        _formKey.currentState.save();
                        if (_formKey.currentState.validate()) {
                          Navigator.pop(context);
                        }
                      },
                    ),

                    ElevatedButton(
                      child: Text('SIGN IN'),
                      style: ElevatedButton.styleFrom(
                        primary: elevatedButtonPrimaryColor2,
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),);
  }
}