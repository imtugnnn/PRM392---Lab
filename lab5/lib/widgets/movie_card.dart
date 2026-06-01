import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      child: ListTile(
        onTap: onTap,

        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),

          child: Image.network(
            movie.posterUrl,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),

        title: Text(movie.title),

        subtitle: Text(
          "⭐ ${movie.rating} • ${movie.genres.join(", ")}",
        ),

        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
