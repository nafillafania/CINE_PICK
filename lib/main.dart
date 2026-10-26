
import 'package:flutter/material.dart';
import 'data/movie_data.dart';
import 'models/movie.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/favorite_page.dart';
import 'pages/detail_page.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(const CinePickApp());
}

class CinePickApp extends StatelessWidget {
  const CinePickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CinePick',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0B0D17),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8957F5),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final Set<int> _favoriteIds = {};

  List<Movie> get _favoriteMovies {
    return dummyMovies
        .where((movie) => _favoriteIds.contains(movie.id))
        .toList();
  }

  void _toggleFavorite(Movie movie) {
    setState(() {
      if (_favoriteIds.contains(movie.id)) {
        _favoriteIds.remove(movie.id);
      } else {
        _favoriteIds.add(movie.id);
      }
    });
  }

  void _openDetail(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          movie: movie,
          isFavorite: _favoriteIds.contains(movie.id),
          onFavoriteTap: _toggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        onMovieTap: _openDetail,
        favoriteIds: _favoriteIds,
        onFavoriteTap: _toggleFavorite,
        onSeeAllTap: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      SearchPage(
        favoriteIds: _favoriteIds,
        onFavoriteTap: _toggleFavorite,
      ),
      FavoritePage(
        favoriteMovies: _favoriteMovies,
        favoriteIds: _favoriteIds,
        onFavoriteTap: _toggleFavorite,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
