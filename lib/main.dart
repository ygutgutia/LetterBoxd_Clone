import 'package:flutter/material.dart';
import 'loginPages/forgetPasswordPage.dart';
import 'loginPages/loginpage.dart';
import 'themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
      title: 'MyAppPage',
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
        fontFamily: 'Oswald',
      ),

      routes: {

				'/': (BuildContext context) => LoginPage(),
        // '/homepage': (BuildContext context) => MyHomePage(),
        '/forgetPassword':  (BuildContext context) => ForgetPassword(),
        // '/signupdetails':  (BuildContext context) => SignUpDetails(),
			},
		);
	}
}