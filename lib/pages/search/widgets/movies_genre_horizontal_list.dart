import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';
import 'package:movie_app/pages/widgets/movie_poster_item.dart';

import '../../movie_detail/movie_detail_page.dart';

class MoviesGenreHorizontalList extends StatelessWidget {
  final List<Movie> movies;
  const MoviesGenreHorizontalList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 195,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  MovieDetailPage(movieId: movies[index].id)));
            },
              child: MoviePosterItem(movie: movies[index]));
      },),
    );
  }
}
