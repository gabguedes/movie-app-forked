import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/movie_review_model.dart';

import '../../../common/utils.dart';

class ReviewItem extends StatelessWidget {
  final MovieReviewModel review;
  const ReviewItem({super.key, required this.review});


  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MM-dd-yyyy');

    return Stack(
      // alignment: Alignment.topLeft,
      children: [
        Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.white10,
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                            review.authorDetails.avatarpath.isNotEmpty
                                ? Image.network(
                              '$imageUrl${review.authorDetails.avatarpath}',
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('images/image_not_found.png'),
                            ).image
                                : Image.asset('images/image_not_found.png').image,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(review.author),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text("${review.authorDetails.rating.toString()}/10")
                        ],
                      ),
                    ],
                  ),
                  Text(review.content, maxLines: 6, style: const TextStyle(overflow: TextOverflow.ellipsis),),
                  // Text(review.createdAt == null ? "" : formatter.format(review.createdAt!)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
