import 'package:flutter/material.dart';
import 'package:flutter_movies_up_25/movie/movie_bloc.dart';
import 'package:flutter_movies_up_25/pages/movie_page.dart';
import 'package:flutter_movies_up_25/utils/alerts.dart';
import 'package:flutter_movies_up_25/utils/nav.dart';

import 'movie.dart';
import 'movies_service.dart';

class TabMovies extends StatefulWidget {
  @override
  _TabMoviesState createState() => _TabMoviesState();
}

class _TabMoviesState extends State<TabMovies> {

  final _bloc = MovieBloc();

//  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    _bloc.fetch();

//    Future<List<Movie>> list = MovieService.getMovies();
//
//    list.then((movies){
//      setState(() {
//        this.movies = movies;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }

        List<Movie> movies = snapshot.data;
        return _listView(movies);
      },
    );;
  }

  _future() {
    Future<List<Movie>> future = MovieService.getMovies();

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }

        List<Movie> movies = snapshot.data;
        return _listView(movies);
      },
    );
  }

  _listView(List<Movie> movies) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, idx) {
          Movie m = movies[idx];

          return GestureDetector(
            onTap: () {
              _onClickMovie(context, m);
            },
            child: Column(
              children: <Widget>[
                Text(
                  m.title,
                  style: TextStyle(fontSize: 36),
                ),
                Image.network(m.urlFoto),
              ],
            ),
          );
        });
  }

  void _onClickMovie(context, Movie m) {
    push(context, MoviePage(m));
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.close();
  }
}
