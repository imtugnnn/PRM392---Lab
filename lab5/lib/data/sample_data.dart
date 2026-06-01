import '../models/movie.dart';

List<Movie> movies = [
  Movie(
    id: 1,
    title: "Dune: Part Two",
    posterUrl:
        "https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",

    overview:
        "Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.",

    genres: ["Sci-Fi", "Adventure", "Drama"],

    rating: 8.6,

    trailers: [
      "Official Trailer #1",
      "IMAX Sneak Peek",
    ],
  ),

  Movie(
    id: 2,
    title: "Deadpool & Wolverine",

    posterUrl:
        "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",

    overview:
        "Wade Wilson teams up with Wolverine for a multiverse adventure full of chaos and comedy.",

    genres: ["Action", "Comedy"],

    rating: 8.3,

    trailers: [
      "Red Band Trailer",
      "Behind The Scenes",
    ],
  ),
];
