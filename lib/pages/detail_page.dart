
import 'package:flutter/material.dart';
import '../models/movie.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;
  final bool isFavorite;
  final ValueChanged<Movie> onFavoriteTap;

  const DetailPage({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    widget.onFavoriteTap(widget.movie);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite
              ? 'Film ditambahkan ke Favorit!'
              : 'Film dihapus dari Favorit.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0D17),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF0B0D17),
            foregroundColor: Colors.white,
            pinned: true,
            expandedHeight: 380,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.posterUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: Color(0xFF211B35),
                        child: Center(
                          child: Icon(
                            Icons.movie_outlined,
                            color: Color(0xFFA78BFA),
                            size: 80,
                          ),
                        ),
                      );
                    },
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x33000000),
                          Color(0xFF0B0D17),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFC857),
                        size: 19,
                      ),
                      Text(
                        movie.rating
                            .toStringAsFixed(1)
                            .replaceAll('.', ','),
                        style: const TextStyle(
                          color: Color(0xFFFFC857),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '/ 10',
                        style: TextStyle(
                          color: Color(0xFF9295AA),
                        ),
                      ),
                      Text(
                        movie.year,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF211B35),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          movie.genre,
                          style: const TextStyle(
                            color: Color(0xFFA78BFA),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // Durasi film
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        color: Color(0xFFA78BFA),
                        size: 19,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        movie.duration > 0
                            ? '${movie.duration} menit'
                            : 'Durasi belum tersedia',
                        style: const TextStyle(
                          color: Color(0xFFB0B2C3),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  const Text(
                    'Sinopsis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.synopsis.trim().isNotEmpty
                        ? movie.synopsis
                        : 'Sinopsis belum tersedia.',
                    style: const TextStyle(
                      color: Color(0xFFB0B2C3),
                      fontSize: 14,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Daftar pemeran
                  const Text(
                    'Pemeran',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (movie.cast.isEmpty)
                    const Text(
                      'Informasi pemeran belum tersedia.',
                      style: TextStyle(
                        color: Color(0xFFB0B2C3),
                        fontSize: 14,
                      ),
                    )
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: movie.cast.map((actor) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF211B35),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            actor,
                            style: const TextStyle(
                              color: Color(0xFFE6DFFF),
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 30),

                  // Tombol favorit
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: _toggleFavorite,
                      style: FilledButton.styleFrom(
                        backgroundColor: _isFavorite
                            ? const Color(0xFF211B35)
                            : const Color(0xFF8957F5),
                        foregroundColor: Colors.white,
                      ),
                      icon: Icon(
                        _isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                      ),
                      label: Text(
                        _isFavorite
                            ? 'Hapus dari Favorit'
                            : 'Tambah ke Favorit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
