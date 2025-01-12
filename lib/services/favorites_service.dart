import 'package:hive/hive.dart';
import '../models/movie.dart';

class FavoritesService {
  static const String boxName = 'favorites';
  
  Future<Box<Movie>> _openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<Movie>(boxName);
    }
    return Hive.box<Movie>(boxName);
  }

  Future<List<Movie>> getFavorites() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> toggleFavorite(Movie movie) async {
    final box = await _openBox();
    if (box.containsKey(movie.id)) {
      await box.delete(movie.id);
    } else {
      await box.put(movie.id, movie);
    }
  }

  Future<bool> isFavorite(int movieId) async {
    final box = await _openBox();
    return box.containsKey(movieId);
  }
}
