import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';
import 'package:movie_app/pages/search/widgets/movies_genre_horizontal_list.dart';
import 'package:movie_app/services/api_services.dart';

import '../../models/movie_model.dart';
import '../widgets/movie_vertical_grid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ApiServices apiServices = ApiServices();
  late Future<Result> searchResult;
  late Future<Result> adventureMovies;
  late Future<Result> dramaMovies;
  late Future<Result> animationMovies;
  TextEditingController searchController = TextEditingController();

  bool isSearching = false;

  void searchQuery(String query) {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        adventureMovies = apiServices.getMoviesByGenre(genreId: 12);
        dramaMovies = apiServices.getMoviesByGenre(genreId: 18);
        animationMovies = apiServices.getMoviesByGenre(genreId: 16);
      });
    } else {
      setState(() {
        isSearching = true;
        searchResult = apiServices.getQueryMovies(query: query);
      });
    }
  }

  @override
  void initState() {
    searchResult = apiServices.getPopularMovies();
    adventureMovies = apiServices.getMoviesByGenre(genreId: 12);
    dramaMovies = apiServices.getMoviesByGenre(genreId: 18);
    animationMovies = apiServices.getMoviesByGenre(genreId: 16);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoSearchTextField(
                  controller: searchController,
                  padding: const EdgeInsets.all(10.0),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    searchQuery(searchController.text);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                isSearching == true ? 'Search' : 'Discover',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              isSearching == true
                  ? FutureBuilder(
                      future: searchResult,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          return MoviesVerticalList(
                            movies: snapshot.data!.movies,
                            length: snapshot.data!.movies.length,
                          );
                        }
                        return const SizedBox();
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Text(
                            'If you like Adventure:',
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: adventureMovies,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              return MoviesGenreHorizontalList(
                                  movies: snapshot.data!.movies);
                            }
                            return const SizedBox();
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Text(
                            "If you like Drama:",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: dramaMovies,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              return MoviesGenreHorizontalList(
                                  movies: snapshot.data!.movies);
                            }
                            return const SizedBox();
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Text(
                            "If you like Animation:",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: animationMovies,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              return MoviesGenreHorizontalList(
                                  movies: snapshot.data!.movies);
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
