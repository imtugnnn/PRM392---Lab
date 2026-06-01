import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() =>
      _MovieDetailScreenState();
}

class _MovieDetailScreenState
    extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),

                Container(
                  height: 300,

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 16,

                  child: Text(
                    movie.title,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Wrap(
                spacing: 8,

                children: movie.genres.map((genre) {
                  return Chip(
                    label: Text(genre),
                  );
                }).toList(),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Text(
                movie.overview,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,

              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },

                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,

                        color: Colors.red,
                      ),
                    ),

                    const Text("Favorite"),
                  ],
                ),

                Column(
                  children: [
                    IconButton(
                      onPressed: () {},

                      icon: const Icon(Icons.star),
                    ),

                    const Text("Rate"),
                  ],
                ),

                Column(
                  children: [
                    IconButton(
                      onPressed: () {},

                      icon: const Icon(Icons.share),
                    ),

                    const Text("Share"),
                  ],
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.all(16),

              child: Text(
                "Trailers",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount: movie.trailers.length,

              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.play_circle),

                  title: Text(movie.trailers[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
