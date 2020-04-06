import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Widget movieText;
  final Widget moviePoster;

  const MovieCard({this.movieText, this.moviePoster});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                moviePoster,
                movieText,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
