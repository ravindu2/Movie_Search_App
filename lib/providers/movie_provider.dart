import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _movies = [
    Movie(
      id: 1,
      title: "Inception",
      overview: "A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
      posterUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fencrypted-tbn3.gstatic.com%2Fimages%3Fq%3Dtbn%3AANd9GcTnPXL0OklxeuT6B2J1jLwJX9Uhczxwa0SX27UiE6cj0GDFq0zO&psig=AOvVaw0QTWElEBp091IPQv6xm3he&ust=1736711602165000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCLj7k4O57ooDFQAAAAAdAAAAABAE",
      releaseYear: "2010",
      rating: 8.8,
      genre: "Sci-Fi",
    ),
    Movie(
      id: 2,
      title: "The Dark Knight",
      overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      posterUrl: "https://example.com/dark_knight.jpg",
      releaseYear: "2008",
      rating: 9.0,
      genre: "Action",
    ),
    Movie(
      id: 3,
      title: "The Darkffdd Knight",
      overview: "When the meffgdnace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      posterUrl: "https://example.com/dark_knight.jpg",
      releaseYear: "2018",
      rating: 1.0,
      genre: "Action",
    ),
    Movie(
      id: 4,
      title: "The Dark Knight",
      overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      posterUrl: "https://example.com/dark_knight.jpg",
      releaseYear: "2008",
      rating: 9.0,
      genre: "Action",
    ),
    Movie(
      id: 5,
      title: "The Dark Knight",
      overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      posterUrl: "https://example.com/dark_knight.jpg",
      releaseYear: "2008",
      rating: 9.0,
      genre: "Action",
    ),
    Movie(
      id: 6,
      title: "The Dark Knight",
      overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      posterUrl: "https://example.com/dark_knight.jpg",
      releaseYear: "2008",
      rating: 9.0,
      genre: "Action",
    ),
    Movie(
      id: 7,
      title: "The Dark Knight",
      overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      posterUrl: "https://example.com/dark_knight.jpg",
      releaseYear: "2008",
      rating: 9.0,
      genre: "Action",
    ),
    Movie(
      id: 8,
      title: "The Dark Knight",
      overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      posterUrl: "https://example.com/dark_knight.jpg",
      releaseYear: "2008",
      rating: 9.0,
      genre: "Action",
    ),
    // Add more mock movies here
  ];

  List<Movie> get movies => _movies;
  List<Movie> _filteredMovies = [];
  List<Movie> get filteredMovies => _filteredMovies.isEmpty ? _movies : _filteredMovies;

  void searchMovies(String query) {
    if (query.isEmpty) {
      _filteredMovies = [];
    } else {
      _filteredMovies = _movies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterByYear(String year) {
    if (year.isEmpty) {
      _filteredMovies = [];
    } else {
      _filteredMovies = _movies
          .where((movie) => movie.releaseYear == year)
          .toList();
    }
    notifyListeners();
  }

  void filterByGenre(String genre) {
    if (genre.isEmpty) {
      _filteredMovies = [];
    } else {
      _filteredMovies = _movies
          .where((movie) => movie.genre.toLowerCase() == genre.toLowerCase())
          .toList();
    }
    notifyListeners();
  }
}
