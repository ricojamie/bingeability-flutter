import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'movie_card.dart';

Future<Movie> getMovie() async {
  final response = await http.get(
      'https://api.themoviedb.org/3/movie/245891?api_key=1ccc54f0dae4c12535028821a1f3019c&language=en-US');

  if (response.statusCode == 200) {
    return Movie.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

class Movie {
  final String title;
  final String poster;

  Movie({this.title, this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(title: json['original_title'], poster: json['poster_path']);
  }
}

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Future<Movie> futureMovie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMovie = getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies!"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder<Movie>(
            future: futureMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MovieCard(
                  movieText: Text(snapshot.data.title),
                  moviePoster: Image.network(
                      'https://image.tmdb.org/t/p/w185${snapshot.data.poster}'),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
