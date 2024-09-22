import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';
import 'package:movie_app/pages/widgets/movie_poster_item.dart';

import '../movie_detail/movie_detail_page.dart';

class MoviesVerticalList extends StatelessWidget {
  final List<Movie> movies;
  final int length;

  const MoviesVerticalList(
      {super.key,
      required this.movies, required this.length});

  @override
  Widget build(BuildContext context) {

    final double height = (length/3).ceilToDouble();
    return Container(
      height: height * 200,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailPage(movieId: movies[index].id)));
              },
              child: MoviePosterItem(movie: movies[index]));
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 8, mainAxisExtent: 190),
      ),
    );
  }
}
