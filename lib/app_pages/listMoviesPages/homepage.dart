import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:letterboxd/apis/movie_list.dart';
import 'package:letterboxd/app_pages/drawerFunc.dart';
import 'package:letterboxd/themes.dart';
import 'package:letterboxd/app_pages/listMoviesPages/loadMovieCards.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User curruser;
  bool isMovieListLoading = true;
  bool success = false;

  @override
  void initState() {
    curruser = FirebaseAuth.instance.currentUser;
    _fetchlist();
    super.initState();
  }

  void _fetchlist() async {
    success = await context.read<MovieList>().fetchMovies();
    setState(() {
      isMovieListLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBGColor,
      drawer: new WidgetDrawer("curruser - jazzbythe", curruser.email),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie List'),
      ),
      body: isMovieListLoading ? Center(child: CircularProgressIndicator()) : 
            !success ? Center(child: Text("Load Failed"),) :
          Column(
            children: <Widget>[
              Expanded(
                child: MovieDispCards(),
              ),
            ],
          ),
    );
  }
}