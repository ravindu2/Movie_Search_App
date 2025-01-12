import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            actions: [
              Consumer<MovieProvider>(
                builder: (context, movieProvider, child) {
                  final isFavorite = movieProvider.favorites
                      .any((fav) => fav.id == movie.id);

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
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title),
              background: Image.network(
                movie.fullPosterPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.movie)),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
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
                Text(
                  'Overview',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Text(
                  movie.overview,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
