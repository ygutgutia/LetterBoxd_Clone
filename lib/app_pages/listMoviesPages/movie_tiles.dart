import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';

import 'package:letterboxd/models/movie_detail.dart';
import 'package:letterboxd/themes.dart';

class MovieTile extends StatelessWidget {
  final List<Movies> products;
  final int index;
  final bool likedByUser;

  MovieTile(this.products, this.index, this.likedByUser);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorcardBG,
      elevation: 18.0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.pushNamed(context, '/moviedetails', arguments: [products[index], likedByUser]);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FadeInImage(
                      image: NetworkImage(products[index].posterPath),
                      placeholder: AssetImage('assets/images/imgLoading.jpg'),
                      width: 60,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(products[index].title, style: TextStyle(color: CardText),),
                          subtitle: Text(
                            'Secondary Text',
                            style: TextStyle(color: cardTextSubs),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          alignment: Alignment.topLeft,
                          child: Text(
                            products[index].overview,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: cardTextSubs),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.all(0.0),
                              color: likedByUser ? Colors.red : Colors.black,
                              icon: const Icon(Icons.favorite, size: 24.0),
                              tooltip: 'Add to Favs',
                              onPressed: () {
                                print("Pressed");
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, size: 24.0, color: Colors.green),
                              tooltip: 'Share',
                              onPressed: () {
                                // await Share.share('Check out the movie: '+products[index].title);
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
