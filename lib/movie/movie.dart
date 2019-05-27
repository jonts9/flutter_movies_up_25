class Movie {
  int id;
  String title;
  String overview;
  String poster_path;

  String get urlFoto => "https://image.tmdb.org/t/p/w300$poster_path";

  Movie.fromJson(Map<String, dynamic> map) :
        id = map["id"],
        title = map["title"],
        overview = map["overview"],
        poster_path = map["poster_path"];

  Map toMap() {
    Map<String,dynamic> map = {
      "title": title,
      "poster_path": poster_path,
      "overview": overview
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }
}
