
import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  final Set<int> favoriteIds;
  final ValueChanged<Movie> onFavoriteTap;

  const SearchPage({
    super.key,
    required this.favoriteIds,
    required this.onFavoriteTap,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _keyword = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasilPencarian = dummyMovies.where((movie) {
      return movie.title
          .toLowerCase()
          .contains(_keyword.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0D17),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0D17),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cari Film',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _keyword = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Cari judul film...',
              hintStyle: const TextStyle(
                color: Color(0xFF9295AA),
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Color(0xFFA78BFA),
              ),
              suffixIcon: _keyword.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _keyword = '';
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFF121522),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            _keyword.isEmpty
                ? 'Semua Film (${hasilPencarian.length})'
                : 'Hasil Pencarian (${hasilPencarian.length})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),

          if (hasilPencarian.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: [
                  Icon(
                    Icons.movie_filter_outlined,
                    color: Color(0xFF9295AA),
                    size: 50,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Film tidak ditemukan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Coba gunakan kata kunci lain.',
                    style: TextStyle(
                      color: Color(0xFF9295AA),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hasilPencarian.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 18,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                final movie = hasilPencarian[index];

                return MovieCard(
                  movie: movie,
                  isFavorite:
                      widget.favoriteIds.contains(movie.id),
                  onFavoriteTap: () {
                    widget.onFavoriteTap(movie);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          movie: movie,
                          isFavorite:
                              widget.favoriteIds.contains(movie.id),
                          onFavoriteTap: widget.onFavoriteTap,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
