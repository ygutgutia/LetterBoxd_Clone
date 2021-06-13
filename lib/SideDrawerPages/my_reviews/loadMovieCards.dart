import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letterboxd/apis/movie_list.dart';
import 'package:letterboxd/models/movie_detail.dart';
import 'package:letterboxd/appPages/listMoviesPages/movie_tiles.dart';
import 'package:letterboxd/apis/userData.dart';

class MovieDispCards extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Movies> products = context.read<MovieList>().products;
    return (products.length <= 0) ? Center(child: Text('No Movies Found'))
      : ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index){
            bool isLiked = context.watch<UserData>().isLikedByUser(products[index].id);
            if(isLiked)
              return MovieTile(products, index, isLiked);
            else
              return Container();
          }
        );
  }
}