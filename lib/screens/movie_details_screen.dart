import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content Section
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fullscreen Image
                Image.network(
                  movie.fullPosterPath,
                  height: 300, // Set a fixed height for the image
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 300,
                    color: Colors.grey.shade300,
                    child: Center(child: Icon(Icons.movie, size: 80)),
                  ),
                ),
                // Movie Details Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        movie.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Release Date: ${movie.releaseDate}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Overview',
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 500),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),

                      SizedBox(height: 8),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            movie.overview,
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            speed: const Duration(milliseconds: 20),
                          ),
                        ],
                        totalRepeatCount: 1, 
                        pause: const Duration(
                            milliseconds: 400), 
                        displayFullTextOnTap: true, 
                        stopPauseOnTap:
                            true, 
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: Consumer<MovieProvider>(
              builder: (context, movieProvider, child) {
                final isFavorite =
                    movieProvider.favorites.any((fav) => fav.id == movie.id);
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await movieProvider.toggleFavorite(movie);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
