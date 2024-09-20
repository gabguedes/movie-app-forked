import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/movie_detail/movie_detail_page.dart';
import 'package:movie_app/widgets/custom_card_thumbnail.dart';

class NowPlayingList extends StatefulWidget {
  final List<Movie> movies;
  const NowPlayingList({super.key, required this.movies});

  @override
  State<NowPlayingList> createState() => _NowPlayingListState();
}

class _NowPlayingListState extends State<NowPlayingList> {
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  int currentPage = 0;
  int numPaginas = 5;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            itemCount: numPaginas,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      MovieDetailPage(movieId: widget.movies[index].id)));
                },
                child: CustomCardThumbnail(
                    imageAsset: widget.movies[index].posterPath),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicators(),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicatorList = [];
    for (int i = 0; i < numPaginas; i++) {
      indicatorList.add(_buildIndicator(i == currentPage));
    }
    return indicatorList;
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
