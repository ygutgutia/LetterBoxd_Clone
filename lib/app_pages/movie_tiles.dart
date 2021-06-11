import 'package:flutter/material.dart';
import '../models/movie_detail.dart';

class MovieTile extends StatelessWidget{

  final List<Movies> products;
  final int index;

  MovieTile(this.products, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 18.0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(8),
        child: FadeInImage(image: NetworkImage(products[index].posterPath), placeholder: AssetImage('assets/images/imgLoading.jpg'),),),
      
        Padding(padding: EdgeInsets.all(5),
            child: Text('Guest House: '+products[index].overview,
            style: TextStyle(fontSize: 18),),
        ),
        Padding(padding: EdgeInsets.all(5),
        child: Text('Total Numer of Rooms: '+products[index].originalLanguage,
            style: TextStyle(fontSize: 18),),),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
          ElevatedButton(
            child: Column(children: <Widget>[Icon(Icons.info), Text('Details')],),
            onPressed: () => {
              // Navigator.pushNamed(context, '/0/'+products[index].voteCount),
           },
          ),
        ]),
        
      ],
    )
    );
  }
}