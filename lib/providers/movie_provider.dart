import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _error = '';

  List<Movie> get movies => _movies;
  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadNowPlayingMovies() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      _movies = await _apiService.getNowPlayingMovies();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      _searchResults = await _apiService.searchMovies(query);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
