import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _movies = [
    Movie(
      title: 'Inception',
      posterPath: 'assets/inception.jpg',
      overview: 'A thief who steals corporate secrets through dream-sharing technology.',
      releaseYear: '2010',
      rating: 8.8,
    ),
    Movie(
      title: 'The Dark Knight',
      posterPath: 'assets/dark_knight.jpg',
      overview: 'Batman fights against organized crime in Gotham City.',
      releaseYear: '2008',
      rating: 9.0,
    ),
    // Add more demo movies here
  ];

  List<Movie> get movies => _movies;

  List<Movie> searchMovies(String query) {
    if (query.isEmpty) return _movies;
    return _movies
        .where((movie) =>
            movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}