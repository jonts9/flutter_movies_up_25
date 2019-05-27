import 'package:flutter_movies_up_25/movie/movie_dao.dart';

import 'movie.dart';
import 'dart:convert' as convert;
import 'package:flutter_movies_up_25/domain/response.dart';
import 'package:http/http.dart' as http;


class MovieService {

  static Future<List<Movie>> getMovies() async {

    var url = "https://api.themoviedb.org/3/movie/popular?api_key=9ac4466dcf069ac63db44c560c9e8731&language=pt-BR";

    print(url);

    final response = await http.get(url);

    final json = response.body;
    print(json);

    final map = convert.json.decode(json);

    List mapResults = map["results"];

    List<Movie> list = mapResults.map<Movie>((json){
      return Movie.fromJson(json);
    }).toList();

    return list;

  }

  static Future<bool> favoritar(Movie m) async {
    final dao = MovieDAO.getInstance();
    bool exists = await dao.exists(m);
    if(exists) {
      dao.deleteMovie(m.id);
      return false;
    } else {
      dao.saveMovie(m);
      return true;
    }
  }

//  static List<Movie> getMovies() {
//    List<Movie> list = [];
//
//    list.add(Movie("John Wick", "https://image.tmdb.org/t/p/w300/eDIxIvpBm5MsHuafEEmCQIKfG4u.jpg"));
//    list.add(Movie("Aladdin", "https://image.tmdb.org/t/p/w300/cYlzLYlhUXS0kW9T3ttAQ6fvZuV.jpg"));
//    list.add(Movie("Vingadores", "https://image.tmdb.org/t/p/w300/q6725aR8Zs4IwGMXzZT8aC8lh41.jpg"));
//
//    return list;
//  }
}