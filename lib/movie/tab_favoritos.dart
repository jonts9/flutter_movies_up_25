import 'package:flutter/material.dart';
import 'package:flutter_movies_up_25/movie/movie_bloc.dart';
import 'package:flutter_movies_up_25/pages/movie_page.dart';
import 'package:flutter_movies_up_25/utils/alerts.dart';
import 'package:flutter_movies_up_25/utils/nav.dart';

import 'movie.dart';

class TabFavoritos extends StatefulWidget {
  @override
  _TabFavoritosState createState() => _TabFavoritosState();
}

class _TabFavoritosState extends State<TabFavoritos> {

  final _bloc = MovieBloc();

  @override
  void initState() {
    super.initState();

    _bloc.fetchDb();
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
