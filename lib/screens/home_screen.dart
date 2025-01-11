import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(),
          ),
          FilterBar(),
          Expanded(
            child: MovieList(),
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
          borderRadius: BorderRadius.circular(12.0),  
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),  
          borderSide: BorderSide(color: Colors.grey),  
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), 
          borderSide: BorderSide(color: Colors.blue),  
        ),
      ),
      onChanged: (value) {
        Provider.of<MovieProvider>(context, listen: false).searchMovies(value);
      },
    );
  }
}


class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              hint: Text('Filter by Genre'),
              isExpanded: true,
              items: ['Action', 'Sci-Fi', 'Drama', 'Comedy']
                  .map((genre) => DropdownMenuItem(
                        value: genre,
                        child: Text(genre),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  Provider.of<MovieProvider>(context, listen: false)
                      .filterByGenre(value);
                }
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: DropdownButton<String>(
              hint: Text('Filter by Year'),
              isExpanded: true,
              items: ['2008', '2009', '2010', '2011']
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  Provider.of<MovieProvider>(context, listen: false)
                      .filterByYear(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            crossAxisSpacing: 8.0, // Space between columns
            mainAxisSpacing: 8.0, // Space between rows
            childAspectRatio: 0.7, // Aspect ratio of each card (adjust as needed)
          ),
          itemCount: movieProvider.filteredMovies.length,
          itemBuilder: (context, index) {
            final movie = movieProvider.filteredMovies[index];
            return MovieCard(movie: movie);
          },
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to MovieDetailsScreen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster
            Image.network(
              movie.posterUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.movie, size: 50),
            ),
            SizedBox(height: 8),
            // Movie title and info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                movie.title,
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${movie.releaseYear} • ${movie.genre}',
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 8),
            // Movie rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '★ ${movie.rating}',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

