import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letterboxd/routes.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:letterboxd/apis/movie_list.dart';
import 'package:letterboxd/themes.dart';
// import 'package:letterboxd/loginPages/SignUpUserDetails.dart';
// import 'package:letterboxd/loginPages/forgetPasswordPage.dart';
import 'package:letterboxd/apis/authentication_service.dart';
import 'package:letterboxd/loginPages/loginpage.dart';
// import 'package:letterboxd/SideDrawerPages/profile.dart';
import 'package:letterboxd/app_pages/listMoviesPages/homepage.dart';
// import 'package:letterboxd/app_pages/movieData/movieExpand.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(create: (_) => AuthenticationService(FirebaseAuth.instance, FirebaseFirestore.instance)),
        Provider<MovieList>(create: (_) => MovieList())
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyAppPage',
        theme: ThemeData(
          primarySwatch: primarySwatchColor,
          fontFamily: 'assets/Fonts/Oswald',
        ),

        home: IntroScreen(),

        onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => makeRoute(
            context: context,
            routeName: settings.name,
            arguments: settings.arguments,
          ),
          maintainState: true,
          fullscreenDialog: false,
        );
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
        'Welcome To LetterBoxd!',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset('assets/images/splashScreen.jpg', fit: BoxFit.scaleDown),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red
    );
  }
}