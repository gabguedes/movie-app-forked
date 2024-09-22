import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

import '../../common/utils.dart';

class MoviePosterItem extends StatelessWidget {
  final Movie movie;

  const MoviePosterItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: movie.posterPath.isNotEmpty ? Image.network(
            '$imageUrl${movie.posterPath}',
            errorBuilder: (context, error, stackTrace) => Image.asset('images/image_not_found.png'),
          ).image : Image.asset('images/image_not_found.png').image,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black26.withOpacity(0.15),
            Colors.white10,
          ],
        ),
      ),
    );
  }
}
