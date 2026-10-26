
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class FavoritePage extends StatelessWidget {
  final List<Movie> favoriteMovies;
  final Set<int> favoriteIds;
  final ValueChanged<Movie> onFavoriteTap;

  const FavoritePage({
    super.key,
    required this.favoriteMovies,
    required this.favoriteIds,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D17),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0D17),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favoritmu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cerita pilihanmu, tersimpan di sini.',
              style: TextStyle(
                color: Color(0xFF9295AA),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(
                  Icons.favorite_border_rounded,
                  color: Color(0xFFA78BFA),
                  size: 17,
                ),
                const SizedBox(width: 7),
                Text(
                  '${favoriteMovies.length} film disimpan',
                  style: const TextStyle(
                    color: Color(0xFFA78BFA),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Expanded(
              child: favoriteMovies.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            color: Color(0xFF9295AA),
                            size: 55,
                          ),
                          SizedBox(height: 14),
                          Text(
                            'Belum ada film favorit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Tambahkan film yang kamu sukai.',
                            style: TextStyle(
                              color: Color(0xFF9295AA),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      itemCount: favoriteMovies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.55,
                      ),
                      itemBuilder: (context, index) {
                        final movie = favoriteMovies[index];

                        return MovieCard(
                          movie: movie,
                          isFavorite: favoriteIds.contains(movie.id),
                          onFavoriteTap: () => onFavoriteTap(movie),
                          onTap: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
