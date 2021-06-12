//Will use later
import 'package:flutter/material.dart';

class UserDetail{

  String name;
  String username;
  String email;
  String dob;
  String photoLink;
  String phNo;
  List<int> likedMovies;


  UserDetail({
    @required this.name,
    @required this.username,
    @required this.email,
    @required this.dob,
    @required this.photoLink,
    @required this.phNo,
    @required this.likedMovies,
  });

}