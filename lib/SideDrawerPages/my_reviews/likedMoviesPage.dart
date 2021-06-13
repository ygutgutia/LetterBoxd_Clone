import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:letterboxd/themes.dart';
import 'package:letterboxd/sideDrawerPages/my_reviews/loadMovieCards.dart';

class LikedMoviePage extends StatefulWidget {
  @override
  _LikedMoviePageState createState() => _LikedMoviePageState();
}

class _LikedMoviePageState extends State<LikedMoviePage> {
  User curruser;

  @override
  void initState() {
    curruser = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBGColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favourites'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MovieDispCards(),
          ),
        ],
      ),
    );
  }
}