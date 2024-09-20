import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/top_rated/widgets/top_rated_movie.dart';
import 'package:movie_app/services/api_services.dart';

import '../movie_detail/movie_detail_page.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({super.key});

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  ApiServices apiServices = ApiServices();
  late Future<Result> movies;

  @override
  void initState() {
    movies = apiServices.getTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: FutureBuilder<Result>(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.movies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          MovieDetailPage(movieId: snapshot.data!.movies[index].id)));
                    },
                    child: TopRatedMovie(movie: snapshot.data!.movies[index]));
              },
            );
          }
      ),
    );
  }
}
