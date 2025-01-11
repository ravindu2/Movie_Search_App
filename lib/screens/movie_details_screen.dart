import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),  
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.contain,  
                  height: 300, 
                  width: double.infinity,  
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.movie, size: 200),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      // Movie Release Year and Genre
                      Text(
                        '${movie.releaseYear} • ${movie.genre}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Spacer(),
                      // Rating Icon and Text
                      Icon(Icons.star, color: Colors.amber),
                      Text(
                        ' ${movie.rating}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Overview section
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
