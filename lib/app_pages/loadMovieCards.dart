import 'package:flutter/material.dart';
import '../apis/movie_list.dart';
import '../models/movie_detail.dart';
import 'package:provider/provider.dart';
import 'Movie_Tiles.dart';

class MovieDispCards extends StatelessWidget {

  Widget _buildProductList(List<Movies> products) {
    Widget productCard;
    if(products.length > 0){
      productCard = ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) => MovieTile(products, index),
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