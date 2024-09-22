class MovieReviewResult {
  int id;
  int page;
  List<MovieReviewModel> reviews;

  MovieReviewResult(
      {required this.id, required this.page, required this.reviews});

  factory MovieReviewResult.fromJson(Map<String, dynamic> json) =>
      MovieReviewResult(
          id: json["id"] ?? 0,
          page: json["page"] ?? 0,
          reviews: List<MovieReviewModel>.from(
              json["results"].map((x) => MovieReviewModel.fromJson(x))));
}

class MovieReviewModel {
  String author;
  AuthorDetails authorDetails;
  String content;
  DateTime? createdAt;
  int id;
  DateTime? updatedAt;
  String url;

  MovieReviewModel(
      {required this.author,
      required this.authorDetails,
      required this.content,
      required this.createdAt,
      required this.id,
      required this.updatedAt,
      required this.url});

  factory MovieReviewModel.fromJson(Map<String, dynamic> json) =>
      MovieReviewModel(
          author: json["author"] ?? "",
          authorDetails: AuthorDetails.fromJson(json["author_details"]),
          content: json["content"] ?? "",
          createdAt: DateTime.tryParse(json["created_at"]),
          id: json["id"] ?? 0,
          updatedAt: DateTime.tryParse(json["updated_at"]),
          url: json["url"] ?? "");
}

class AuthorDetails {
  String name;
  String username;
  String avatarpath;
  double rating;

  AuthorDetails(
      {required this.name,
      required this.username,
      required this.avatarpath,
      required this.rating});

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
      name: json["name"] ?? "",
      username: json["username"] ?? "",
      avatarpath: json["avatarpath"] ?? "",
      rating: json["rating"]);
}
