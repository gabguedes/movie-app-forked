import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/reviews/widgets/review_vertical_list.dart';
import 'package:movie_app/services/api_services.dart';

import '../../models/movie_review_model.dart';

class ReviewPage extends StatefulWidget {
  final int movieId;

  const ReviewPage({super.key, required this.movieId});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  ApiServices apiService = ApiServices();
  late Future<MovieReviewResult?> reviews;

  @override
  void initState() {
    reviews = apiService.getReviewsByMovieId(movieId: widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              "Reviews",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            ),
            SizedBox(
              height: 600,
              child: FutureBuilder(
                future: reviews,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return SizedBox(
                        child: ReviewVerticalList(result: snapshot.data!));
                  }
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
