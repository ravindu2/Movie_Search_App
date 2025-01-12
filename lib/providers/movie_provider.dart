import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/filter_options.dart';
import '../services/api_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _error = '';
  FilterOptions? _filterOptions;

  List<Movie> get movies => _getFilteredMovies(_movies);
  List<Movie> get searchResults => _getFilteredMovies(_searchResults);
  bool get isLoading => _isLoading;
  String get error => _error;
  FilterOptions? get filterOptions => _filterOptions;

  List<Movie> _getFilteredMovies(List<Movie> movieList) {
    if (_filterOptions == null) return movieList;

    return movieList.where((movie) {
      bool matchesRating = true;
      bool matchesYear = true;

      if (_filterOptions!.minRating != null) {
        matchesRating = movie.voteAverage >= _filterOptions!.minRating!;
      }

      if (_filterOptions!.year != null) {
        matchesYear = movie.releaseDate.isNotEmpty && 
            movie.releaseDate.substring(0, 4) == _filterOptions!.year.toString();
      }

      return matchesRating && matchesYear;
    }).toList();
  }

  void setFilters(FilterOptions options) {
    _filterOptions = options;
    notifyListeners();
  }

  void clearFilters() {
    _filterOptions = null;
    notifyListeners();
  }

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
