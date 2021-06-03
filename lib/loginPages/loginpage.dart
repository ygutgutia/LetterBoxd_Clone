import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';
import '../themes.dart';


enum AuthPage{
  Login,
  Signup
}

class LoginPage extends StatefulWidget {
  
  @override
  _LoginClass createState() => _LoginClass();
}

class _LoginClass extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordCont = TextEditingController();
  AuthPage _currAuth = AuthPage.Login;
  String emailEntered;
  String passwordEntered;

  bool isUserLoading = false;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: appBGColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign In'),
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
                          emailEntered = value;
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

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: TextFormField(
                        style: TextStyle(color: formFieldTextColor),
                        controller: _passwordCont,
                        obscureText: true,
                        onSaved: (String value) {
                            passwordEntered = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        validator: (String value) {
                          if (_currAuth == AuthPage.Signup && !validateStructure(value)) {
                            return 'Password must have atleast one UC, LC, num, sc, and 6 digits';
                          }else if(value==''){
                            return 'Enter a Password';
                          }
                          return null;
                        },
                      ),
                    ),

                    _currAuth == AuthPage.Signup ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: TextFormField(
                        style: TextStyle(color: formFieldTextColor),
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter the Password again',
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        validator: (String value) {
                          if (_passwordCont.text != value) {
                            return 'Password Doesnt Match';
                          }
                          return null;
                        },
                      ),
                    ) : Container(),

                    SizedBox(height: 13.0,),

                    isUserLoading ? CircularProgressIndicator() :
                                    ElevatedButton(
                                      child: Text(_currAuth == AuthPage.Signup ? 'Sign Up' : 'Login'),
                                        onPressed: () {
                                        _formKey.currentState.save();
                                        if (_formKey.currentState.validate()) {
                                          setState((){
                                            isUserLoading = true;
                                          });
                                          _submitForm();
                                        }
                                      },
                                    ),
                    
                    _currAuth == AuthPage.Login ? TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgetPassword');
                      },
                      child: Text('Forgot Password?'),
                    ) : Container(),

                    TextButton(
                      onPressed: () {
                        _formKey.currentState.reset();
                        setState(() {
                          _currAuth = _currAuth == AuthPage.Login ? AuthPage.Signup : AuthPage.Login;
                        });
                      },
                      child: Text('Switch to ${_currAuth == AuthPage.Login ? 'Signup' : 'Login'}'),
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

  bool validateStructure(String value){
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }

  void _submitForm() async {

    String returnMsg = (_currAuth == AuthPage.Login) ?
            await context.read<AuthenticationService>().signIn(email: emailEntered.trim(), password: passwordEntered.trim()) :
            await context.read<AuthenticationService>().signUp(email: emailEntered.trim(), password: passwordEntered.trim());

    if (returnMsg == "Success") {
      _formKey.currentState.reset();
      isUserLoading = false;
      if(_currAuth == AuthPage.Signup)
        Navigator.pushReplacementNamed(context, '/homepage');
      else
        Navigator.pushReplacementNamed(context, '/homepage');
    }
    else {
      print(returnMsg);
      _formKey.currentState.reset();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Wrong Details"),
            content: Text(returnMsg),
            actions: <Widget>[
              TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        },
      );
    }

  }
}