import 'package:flutter/material.dart';
import 'package:flutter_movies_up_25/movie/movie.dart';
import 'package:flutter_movies_up_25/movie/movie_dao.dart';
import 'package:flutter_movies_up_25/movie/movies_service.dart';
import 'package:flutter_movies_up_25/utils/alerts.dart';



class MoviePage extends StatefulWidget {
  Movie movie;

  MoviePage(this.movie);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  bool favoritado = false;

  get movie => widget.movie;

  @override
  void initState() {
    super.initState();

    MovieDAO.getInstance().exists(movie).then((ok) {
      setState(() {
        favoritado = ok;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(movie.title),
//      ),
      body: _body(context),
    );
  }

  _body(context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.orange,
          expandedHeight: 250,
          pinned: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: favoritado ? Colors.red: Colors.white,
              ),
              onPressed: () {
                _onClickFavoritar(context);
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Text(widget.movie.title),
            background: Image.network(
              widget.movie.urlFoto,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  style: TextStyle(fontSize: 36),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _onClickFavoritar(context) async {
    final b = await MovieService.favoritar(widget.movie);

    if(b) {
      alert(context, "UP","Favoritado com sucesso!");
    } else {
      alert(context, "UP","Removido dos favoritos");
    }

    setState(() {
      this.favoritado = b;
    });
  }
}
