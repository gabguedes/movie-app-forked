import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/pages/reviews/review_page.dart';
import 'package:movie_app/pages/widgets/movie_vertical_grid.dart';

import '../../common/utils.dart';
import '../../models/movie_model.dart';
import '../../services/api_services.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  ApiServices apiService = ApiServices();
  late Future<MovieDetailModel> movieDetail;
  late Future<Result> movieRecommendations;

  @override
  void initState() {
    movieDetail = apiService.getMovieDetail(movieId: widget.movieId);
    movieRecommendations = apiService.getSimilarMovies(movieId: widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: movieDetail,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<String> genresList = [];

                  for (int i = 0; i < snapshot.data!.genres.length; i++) {
                    genresList.add(snapshot.data!.genres[i].name);
                  }

                  String genres = genresList.join(", ");

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height * 0.3,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: snapshot.data!.backdropPath.isNotEmpty
                                ? Image
                                .network(
                              '$imageUrl${snapshot.data!.backdropPath}',
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                  Image.asset(
                                      'images/image_not_found.png'),
                              fit: BoxFit.fitWidth,
                            )
                                .image
                                : Image
                                .asset('images/image_not_found.png')
                                .image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: SafeArea(
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.title,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              genres,
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  overflow: TextOverflow.fade),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data!.releaseDate!.year.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.runtime} min",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${snapshot.data!.voteAverage
                                          .toStringAsFixed(1)}/10',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              snapshot.data!.overview,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            Center(
              child: ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ReviewPage(movieId: widget.movieId)));
              }, child: const Text("View Reviews"),),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "More like this: ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            FutureBuilder(
                future: movieRecommendations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return MoviesVerticalList(
                    movies: snapshot.data!.movies,
                    length: snapshot.data!.movies.length >= 12
                        ? 12
                        : snapshot.data!.movies.length,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
