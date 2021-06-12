import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:letterboxd/apis/userData.dart';
import 'package:letterboxd/models/movie_detail.dart';
import 'package:letterboxd/themes.dart';

class MovieDetails extends StatelessWidget {
  final Movies movieData;

  MovieDetails(this.movieData);

  @override
  Widget build(BuildContext context) {
    bool likedByUser = context.watch<UserData>().isLikedByUser(movieData.id);
    return Scaffold(
      backgroundColor: appBGColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie Detail'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: FadeInImage(
                image: NetworkImage(movieData.posterPath),
                placeholder: AssetImage('assets/imgLoading.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Text(
                'Movie Name : ' + movieData.title,
                style: TextStyle(fontSize: 18, color: generalTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Text(
                'Movie Overview : ' + movieData.overview,
                style: TextStyle(fontSize: 18, color: generalTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Text(
                'Ratings : ' + movieData.voteAverage.toString(),
                style: TextStyle(fontSize: 18, color: generalTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Text(
                'Release Date : ' + movieData.releaseDate,
                style: TextStyle(fontSize: 18, color: generalTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Text(
                'Adult? ' + movieData.adult.toString(),
                style: TextStyle(fontSize: 18, color: generalTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Text(
                'Original Language : ' + movieData.originalLanguage,
                style: TextStyle(fontSize: 18, color: generalTextColor),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 130.0,
        width: 130.0,
        child: FittedBox(
          child: ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: "button1",
                icon: Icon(Icons.favorite, color: likedByUser ? Colors.red : Colors.black),
                backgroundColor: Colors.green,
                label: Text(''),
                onPressed: () {
                  _updateLikes(context, movieData.id, likedByUser);
                }
              ),
              FloatingActionButton.extended(
                heroTag: "button2",
                icon: Icon(Icons.share, color: Colors.black),
                backgroundColor: Colors.green,
                label: Text(''),
                onPressed: () {
                  // Navigator.pushNamed(context, '/dateSelect');
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateLikes(BuildContext context, int movieid, bool likedByUser) async {
    String success = likedByUser ? await context.read<UserData>().updateLikes(movieid, false)
                : await context.read<UserData>().updateLikes(movieid, true);
    Fluttertoast.showToast(  
      msg: success,  
      toastLength: Toast.LENGTH_SHORT,  
      gravity: ToastGravity.BOTTOM,
      backgroundColor: elevatedButtonPrimaryColor2,  
      textColor: hintTextColor  
    );
  }
}
