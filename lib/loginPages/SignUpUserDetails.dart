import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SignUpDetails extends StatefulWidget {  
  @override
  _SignUpDetailsClass createState() => _SignUpDetailsClass();
}

class _SignUpDetailsClass extends State<SignUpDetails> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordCont = TextEditingController();
  String name, phNo, dob, photoLink;

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
                        controller: _passwordCont,
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
                        controller: _passwordCont,
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
                        controller: _passwordCont,
                        obscureText: true,
                        onSaved: (String value) {
                            photoLink = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your photoLink',
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

                    // ScopedModelDescendant<MainModel>(
                    //   builder: (BuildContext context, Widget child, MainModel model) {
                    //     return model.isUserLoading ? CircularProgressIndicator() : ElevatedButton(
                    //       child: Text('Save Details'),
                    //       onPressed: () {
                    //         _formKey.currentState.save();
                    //         if (_formKey.currentState.validate()) {
                    //           if(FirebaseAuth.instance.currentUser.emailVerified){
                    //             model.updateAuthDetails(name, phNo, dob, photoLink);
                    //             Navigator.pushReplacementNamed(context, '/homepage');
                    //           }else{
                    //             Fluttertoast.showToast(
                    //               msg: "Verify your email",
                    //               toastLength: Toast.LENGTH_SHORT,
                    //               gravity: ToastGravity.CENTER,
                    //               timeInSecForIosWeb: 1,
                    //               backgroundColor: Colors.red,
                    //               textColor: Colors.white,
                    //               fontSize: 16.0
                    //             );
                    //           }
                    //         }
                    //       },
                    //     );
                    //   },
                    // ),

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

