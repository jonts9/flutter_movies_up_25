
import 'dart:async';

import 'package:flutter_movies_up_25/movie/movie.dart';
import 'package:flutter_movies_up_25/movie/movie_dao.dart';
import 'package:flutter_movies_up_25/movie/movies_service.dart';

class MovieBloc {

  final _sc = StreamController<List<Movie>>();

  // É a stream
  get stream => _sc.stream;

  void fetch() async {
    List<Movie> list = await MovieService.getMovies();
    // Escreve na Stream
    _sc.sink.add(list);
  }

  void close() {
    _sc.close();
  }

  Future fetchDb() async {
    List<Movie> list = await MovieDAO.getInstance().getMovies();
    // Escreve na Stream
    _sc.sink.add(list);
  }


}