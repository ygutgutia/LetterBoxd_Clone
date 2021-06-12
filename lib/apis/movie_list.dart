import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:letterboxd/apis/moviedb_apikey.dart';
import 'package:letterboxd/models/movie_detail.dart';

class MovieList {
  List<Movies> _movieList;
  MovieList();

  Future<bool> fetchMovies() async {

    final response =  await http.get(Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=$v3AuthAPI&language=en-US&page=1'));
    final Map<String, dynamic> movieListRecv = json.decode(response.body);
    final List<Movies> fetchedMovieList = [];

    if(movieListRecv.containsKey("status_code"))
      return false;

    movieListRecv['results'].forEach((dynamic movieData) {
      final Movies movieInit = Movies(
        posterPath : imgBaseLink+movieData['poster_path'],
        adult : movieData['adult'],
        overview : movieData['overview'],
        releaseDate : movieData['release_date'],
        genreIds : movieData['genre_ids'],
        id : movieData['id'],
        originalTitle : movieData['original_title'],
        originalLanguage : movieData['original_language'],
        title : movieData['title'],
        backdropPath : movieData['backdrop_path'],
        popularity : movieData['popularity'],
        voteCount : movieData['voteCount'],
        video : movieData['video'],
        voteAverage : movieData['vote_average']
      );
      fetchedMovieList.add(movieInit);
    });
    _movieList = fetchedMovieList;
    return true;
  }

  List<Movies> get products {
    return List.from(_movieList);
  }

}