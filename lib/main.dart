import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'SideDrawerPages/profile.dart';
import 'themes.dart';
import 'loginPages/forgetPasswordPage.dart';
import 'loginPages/loginpage.dart';

import 'app_pages/homepage.dart';
import 'loginPages/authentication_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

	@override
	Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyAppPage',
        theme: ThemeData(
          primarySwatch: primarySwatchColor,
          fontFamily: 'Oswald',
        ),

        home: IntroScreen(),

        routes: {
          '/loginpage': (BuildContext context) => LoginPage(),
          '/homepage': (BuildContext context) => HomePage(),
          '/forgetPassword':  (BuildContext context) => ForgetPassword(),
          '/profilePage': (BuildContext context) => UserProfilePage(),
        },
      ),
    );
	}
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
        navigateAfterSeconds: result != null ? HomePage() : LoginPage(),
        seconds: 2,
        title: new Text(
          'Welcome To Meet up!',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset('assets/images/splashScreen.jpg', fit: BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.red);
  }
}