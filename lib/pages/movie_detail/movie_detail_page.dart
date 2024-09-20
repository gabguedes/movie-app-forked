import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail_model.dart';

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

  @override
  void initState() {
    movieDetail = apiService.getMovieDetail(movieId: widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            try {
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
                        image: NetworkImage(
                            '$imageUrl${snapshot.data!.backdropPath}.'),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
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
                                  '${snapshot.data!.voteAverage.toStringAsFixed(1)}/10',
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
            } on Exception {
              return Container(
                child: const Text("Filme não Encontrado"),
              );
            }
          }),
    );
  }
}
