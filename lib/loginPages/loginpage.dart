import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  String email;
  String pass;

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

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: TextFormField(
                        style: TextStyle(color: formFieldTextColor),
                        controller: _passwordCont,
                        obscureText: true,
                        onSaved: (String value) {
                            pass = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        validator: (String value) {
                          if ( _currAuth == AuthPage.Signup && !validateStructure(value)) {
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

                    ElevatedButton(
                      child: Text(_currAuth == AuthPage.Signup ? 'Sign Up' : 'Login'),
                        onPressed: () {
                        _formKey.currentState.save();
                        if (_formKey.currentState.validate()) {
                          // Save
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
}
