import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';  
import '../themes.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool isUserLoading = false;

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
                          controller: emailController,
                          style: TextStyle(color: formFieldTextColor),
                          keyboardType: TextInputType.emailAddress,
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

                      isUserLoading ? CircularProgressIndicator() :
                      ElevatedButton(
                        child: Text('Go'),
                        style: ElevatedButton.styleFrom(
                          primary: elevatedButtonPrimaryColor1,
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          )
                        ),
                        onPressed: () {
                          _formKey.currentState.save();
                          if (_formKey.currentState.validate()) {
                            setState(() { isUserLoading = true; });
                            forgetPasswordMail();
                          }
                        },
                      ),

                      ElevatedButton(
                        child: Text('Sign In'),
                        style: ElevatedButton.styleFrom(
                          primary: elevatedButtonPrimaryColor2,
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600
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
      ),
    );
  }

  void forgetPasswordMail() async {
    String returnMsg = await context.read<AuthenticationService>().forgetPassword(email: emailController.text.trim());
    _formKey.currentState.reset();
    setState(() { isUserLoading = false; });
    if(returnMsg == "Success"){
      Fluttertoast.showToast(  
        msg: 'Email notif Sent',  
        toastLength: Toast.LENGTH_SHORT,  
        gravity: ToastGravity.BOTTOM,
        backgroundColor: elevatedButtonPrimaryColor2,  
        textColor: hintTextColor  
      );
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(  
        msg: returnMsg,  
        toastLength: Toast.LENGTH_SHORT,  
        gravity: ToastGravity.BOTTOM,
        backgroundColor: elevatedButtonPrimaryColor2,  
        textColor: hintTextColor  
      );
    }
  }
}