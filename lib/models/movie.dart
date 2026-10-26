
class Movie {
  final int id;
  final String title;
  final String genre;
  final double rating;
  final String year;
  final int duration;
  final String synopsis;
  final List<String> cast;
  final String posterUrl;

  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.rating,
    required this.year,
    required this.duration,
    required this.synopsis,
    required this.cast,
    required this.posterUrl,
  });
}
