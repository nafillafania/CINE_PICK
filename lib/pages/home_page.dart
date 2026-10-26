import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../models/movie.dart';
import '../widgets/featured_movie.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  final void Function(Movie movie)? onMovieTap;
  final Set<int> favoriteIds;
  final ValueChanged<Movie> onFavoriteTap;
  final VoidCallback? onSeeAllTap;

  const HomePage({
    super.key,
    this.onMovieTap,
    required this.favoriteIds,
    required this.onFavoriteTap,
    this.onSeeAllTap,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final featuredMovie = dummyMovies.first;
    final popularMovies = dummyMovies.skip(1).take(4).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0D17),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          children: [
            // Header aplikasi
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF211B35),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.movie_filter_rounded,
                    color: Color(0xFFA78BFA),
                    size: 25,
                  ),
                ),
                const SizedBox(width: 11),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CinePick',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Temukan film favoritmu',
                      style: TextStyle(
                        color: Color(0xFF9295AA),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Judul halaman
            const Text(
              'Mau nonton apa hari ini?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Pilih film yang cocok dengan suasana hatimu.',
              style: TextStyle(
                color: Color(0xFF9295AA),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 22),

            // Film unggulan
            FeaturedMovie(
              movie: featuredMovie,
              onTap: () {
                widget.onMovieTap?.call(featuredMovie);
              },
            ),

            const SizedBox(height: 28),

            // Judul bagian film populer
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Populer minggu ini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
               TextButton(
                  onPressed: widget.onSeeAllTap,
                  child: const Text(
                    'Lihat semua',
                    style: TextStyle(
                      color: Color(0xFFA78BFA),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Daftar film populer
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: popularMovies.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 18,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                final movie = popularMovies[index];

                return MovieCard(
                  movie: movie,

                  // Status love mengikuti daftar favorit utama
                  isFavorite: widget.favoriteIds.contains(movie.id),

                  // Perubahan favorit dikirim ke main.dart
                  onFavoriteTap: () {
                    widget.onFavoriteTap(movie);
                  },

                  // Buka halaman detail film
                  onTap: () {
                    widget.onMovieTap?.call(movie);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
