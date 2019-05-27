import 'package:flutter/material.dart';
import 'package:flutter_movies_up_25/movie/movie.dart';
import 'package:flutter_movies_up_25/movie/tab_favoritos.dart';
import 'package:flutter_movies_up_25/movie/tab_movies.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Filmes"),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              text: "Filmes",
              icon: Icon(Icons.movie),
            ),
            Tab(text: "Favoritos", icon: Icon(Icons.favorite))
          ]),
        ),
        body: TabBarView(children: [
          TabMovies(),
          TabFavoritos()
        ]),
      ),
    );
  }
}
