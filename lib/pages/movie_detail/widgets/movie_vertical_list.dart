import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';

import '../../movie_detail/movie_detail_page.dart';

class MoviesVerticalList extends StatelessWidget {
  final List<Movie> movies;

  const MoviesVerticalList({super.key, required this.movies});


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 830,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailPage(movieId: movies[index].id)));
              },
              child: MovieHorizontalItem(movie: movies[index]));
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 8, mainAxisExtent: 190),
      ),
    );
  }
}
