import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_details_screen.dart';
import '../models/movie.dart';
import '../models/filter_options.dart';
import '../widgets/filter_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<MovieProvider>();
      provider.loadNowPlayingMovies();
      provider.loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.grey[500],
        title: Text('TMDB Movies', style:TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      color: Colors.white,
      shadows: [
        Shadow(
          offset: Offset(1.0, 1.0),
          blurRadius: 3.0,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    ),),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<MovieProvider>().showOnlyFavorites
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              context.read<MovieProvider>().toggleShowOnlyFavorites();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async {
              final provider = context.read<MovieProvider>();
              final result = await showDialog<FilterOptions>(
                context: context,
                builder: (context) => FilterDialog(
                  initialFilters: provider.filterOptions,
                ),
              );
              if (result != null) {
                provider.setFilters(result);
              }
            },
          ),
          if (context.watch<MovieProvider>().filterOptions != null)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                context.read<MovieProvider>().clearFilters();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(),
          ),
          Expanded(
            child: MovieGrid(),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search movies...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onChanged: (value) {
        context.read<MovieProvider>().searchMovies(value);
      },
    );
  }
}

class MovieGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (provider.error.isNotEmpty) {
          return Center(child: Text(provider.error));
        }

        final movies = provider.showOnlyFavorites
            ? provider.favorites
            : provider.searchResults.isNotEmpty
                ? provider.searchResults
                : provider.movies;

        if (movies.isEmpty) {
          return Center(
            child: Text(
              provider.showOnlyFavorites
                  ? 'No favorite movies found.'
                  : 'No movies found.',
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index]);
          },
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                movie.fullPosterPath,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.movie)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
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
