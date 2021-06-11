import 'package:flutter/material.dart';

import 'package:letterboxd/loginPages/SignUpUserDetails.dart';
import 'package:letterboxd/loginPages/forgetPasswordPage.dart';
import 'package:letterboxd/loginPages/loginpage.dart';
import 'package:letterboxd/SideDrawerPages/profile.dart';
import 'package:letterboxd/app_pages/listMoviesPages/homepage.dart';
import 'package:letterboxd/app_pages/movieData/movieExpand.dart';
import 'package:letterboxd/models/movie_detail.dart';

Widget makeRoute({@required BuildContext context, @required String routeName, Object arguments}){
  final Widget child = _buildRoute(context: context, routeName: routeName, arguments: arguments);
  return child;
}

Widget _buildRoute({ @required BuildContext context, @required String routeName, Object arguments}) {
  switch (routeName) {
    case '/loginpage':
      return LoginPage();
    case '/homepage':
      return HomePage();
    case '/forgetPassword':
      return ForgetPassword();
    case '/profilePage':
      return UserProfilePage();
    case '/signupuserdetail':
      return SignUpDetails();
    case '/moviedetails':
      Movies movie = arguments as Movies;
      return MovieDetails(movie);
    default:
      throw 'Route $routeName is not defined';
  }
}