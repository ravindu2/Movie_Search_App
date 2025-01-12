import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/movie.dart';
import 'providers/movie_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter for the Movie model
  Hive.registerAdapter(MovieAdapter());

  // Open a Hive box for storing favorite movies (you can replace 'favorites' with any name)
  await Hive.openBox<Movie>('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        title: 'TMDB Movies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
