import 'package:hive/hive.dart';

part 'movie.g.dart'; 

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final int id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String overview;
  
  @HiveField(3)
  final String posterPath;
  
  @HiveField(4)
  final String releaseDate;
  
  @HiveField(5)
  final double voteAverage;
  
  @HiveField(6)
  final String backdropPath;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.backdropPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      backdropPath: json['backdrop_path'] ?? '',
    );
  }

  String get fullPosterPath => 
      'https://image.tmdb.org/t/p/w500$posterPath';
  
  String get fullBackdropPath => 
      'https://image.tmdb.org/t/p/original$backdropPath';
}
