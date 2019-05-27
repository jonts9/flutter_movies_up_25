import 'dart:async';

import 'package:flutter_movies_up_25/movie/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDAO {
  static final MovieDAO _instance = new MovieDAO.getInstance();

  factory MovieDAO() => _instance;

  MovieDAO.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movies.db');
    print("db $path");

    // para testes vc pode deletar o banco
    await deleteDatabase(path);

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE movie(id INTEGER PRIMARY KEY, title TEXT, poster_path TEXT'
            ', overview TEXT, vote_average REAL)');
  }

  Future<int> saveMovie(Movie m) async {
    var dbClient = await db;
    int id = await dbClient.insert("movie", m.toMap());
    return id;
  }

  Future<List<Movie>> getMovies() async {
    try {
      final dbClient = await db;

      final mapMovies = await dbClient.rawQuery('select * from movie');

      final list = mapMovies.map<Movie>((json)  {
        return Movie.fromJson(json);
      }).toList();

      return list;
    } catch(error) {
      print(error);
    }
  }

  Future<Movie> getMovie(int id) async {
    var dbClient = await db;
    final result = await dbClient.rawQuery('select * from movie where id = ?',[id]);

    if (result.length > 0) {
      return new Movie.fromJson(result.first);
    }

    return null;
  }

  Future<bool> exists(Movie m) async {
    Movie c = await getMovie(m.id);
    var exists = c != null;
    return exists;
  }

  Future<int> deleteMovie(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from movie where id = ?',[id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}