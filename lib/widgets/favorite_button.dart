import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';

class FavoriteButton extends StatefulWidget {
  final Movie movie;
  final Color? color;

  const FavoriteButton({
    required this.movie,
    this.color,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final provider = context.read<MovieProvider>();
    final isFavorite = await provider.isFavorite(widget.movie);
    if (mounted) {
      setState(() {
        _isFavorite = isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : widget.color,
      ),
      onPressed: () async {
        await context.read<MovieProvider>().toggleFavorite(widget.movie);
        _checkFavoriteStatus();
      },
    );
  }
}
