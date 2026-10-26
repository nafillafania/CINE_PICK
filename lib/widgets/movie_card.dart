
import 'package:flutter/material.dart';
import '../models/movie.dart';

const Color _warnaKartu = Color(0xFF121522);
const Color _warnaUngu = Color(0xFF8957F5);
const Color _warnaTeks = Color(0xFFF5F4FC);
const Color _warnaSekunder = Color(0xFF9295AA);
const Color _warnaEmas = Color(0xFFFFC857);

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.posterUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: _warnaKartu,
                        child: const Center(
                          child: Icon(
                            Icons.movie_outlined,
                            color: _warnaUngu,
                            size: 42,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Material(
                      color: const Color(0xDD101220),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onFavoriteTap,
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.pinkAccent
                                : Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _warnaTeks,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                '${movie.year} · ${movie.genre}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: _warnaSekunder,
                ),
              ),
            ),
            const SizedBox(width: 3),
            const Icon(
              Icons.star_rounded,
              color: _warnaEmas,
              size: 13,
            ),
            Text(
              movie.rating.toStringAsFixed(1).replaceAll('.', ','),
              style: const TextStyle(
                fontSize: 10,
                color: _warnaEmas,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
