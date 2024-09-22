import 'package:flutter/material.dart';
import 'package:movie_app/pages/reviews/widgets/review_item.dart';

import '../../../models/movie_review_model.dart';

class ReviewVerticalList extends StatelessWidget {
  final MovieReviewResult result;
  const ReviewVerticalList ({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 195,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: result.reviews.length,
        itemBuilder: (context, index) {
          return ReviewItem(review: result.reviews[index]);
        },),
    );
  }
}
