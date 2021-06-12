import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letterboxd/apis/movie_list.dart';
import 'package:letterboxd/models/movie_detail.dart';
import 'package:letterboxd/app_pages/listMoviesPages/movie_tiles.dart';
import 'package:letterboxd/apis/userData.dart';

class MovieDispCards extends StatelessWidget {

  Widget _buildProductList(List<Movies> products) {
    Widget productCard;
    if(products.length > 0){
      productCard = ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) => MovieTile(products, index, context.read<UserData>().isLikedByUser(products[index].id)),
      );
    }
    else{
      productCard = Center(child: Text('No Movies Found'));
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList(context.read<MovieList>().products);
  }
}