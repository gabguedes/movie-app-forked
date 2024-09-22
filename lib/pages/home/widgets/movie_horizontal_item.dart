import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieHorizontalItem extends StatelessWidget {
  const MovieHorizontalItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 140,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: movie.posterPath.isNotEmpty ? Image.network(
                '$imageUrl${movie.posterPath}',
                errorBuilder: (context, error, stackTrace) => Image.asset('images/image_not_found.png'),
              ).image : Image.asset('images/image_not_found.png').image,
            ),
          ),
        ),
        Positioned(
          left: 15,
          right: 15,
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie.releaseDate?.year.toString() ?? '',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.voteAverage.toInt().toString(),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
