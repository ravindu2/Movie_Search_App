import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/filter_options.dart';
import '../services/api_service.dart';
import '../services/favorites_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final FavoritesService _favoritesService = FavoritesService();

  List<Movie> _movies = [];
  List<Movie> _searchResults = [];
  List<Movie> _favorites = [];
  bool _isLoading = false;
  bool _showOnlyFavorites = false;
  String _error = '';
  FilterOptions? _filterOptions;

  List<Movie> get movies => _getFilteredMovies(_movies);
  List<Movie> get searchResults => _getFilteredMovies(_searchResults);
  List<Movie> get favorites => _favorites;
  bool get isLoading => _isLoading;
  bool get showOnlyFavorites => _showOnlyFavorites;
  String get error => _error;
  FilterOptions? get filterOptions => _filterOptions;

  // Filter and favorite-related logic
  List<Movie> _getFilteredMovies(List<Movie> movieList) {
    var filteredList = movieList;

    if (_showOnlyFavorites) {
      filteredList = filteredList
          .where((movie) => _favorites.any((fav) => fav.id == movie.id))
          .toList();
    }

    if (_filterOptions == null) return filteredList;

    return filteredList.where((movie) {
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

  void toggleShowOnlyFavorites() {
    _showOnlyFavorites = !_showOnlyFavorites;
    notifyListeners();
  }

  // Favorite-related methods
  Future<void> loadFavorites() async {
    _favorites = await _favoritesService.getFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(Movie movie) async {
    await _favoritesService.toggleFavorite(movie);
    await loadFavorites();
  }

  Future<bool> isFavorite(Movie movie) async {
    return await _favoritesService.isFavorite(movie.id);
  }

  // Movie loading methods
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
