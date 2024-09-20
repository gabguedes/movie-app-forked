class MovieDetailModel {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdbId;
  List<String> originCountry;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;
  DateTime? releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailModel(
      {required this.adult,
      required this.backdropPath,
      required this.belongsToCollection,
      required this.budget,
      required this.genres,
      required this.homepage,
      required this.id,
      required this.imdbId,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.productionCompanies,
      required this.productionCountries,
      required this.releaseDate,
      required this.revenue,
      required this.runtime,
      required this.spokenLanguages,
      required this.status,
      required this.tagline,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"] ?? 0,
        genres: List<Genres>.from(json["genres"].map((x) => Genres.fromJson(x))),
        homepage: json["homepage"] ?? '',
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"] ?? '',
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble() ?? 0,
        posterPath: json["poster_path"] ?? '',
        productionCompanies: List<ProductionCompanies>.from(json["production_companies"].map((x) => ProductionCompanies.fromJson(x))),
        productionCountries: List<ProductionCountries>.from(json["production_countries"].map((x) => ProductionCountries.fromJson(x))),
        releaseDate: DateTime.tryParse(json["release_date"]),
        revenue: json["revenue"] ?? 0,
        runtime: json["runtime"] ?? 0,
        spokenLanguages: List<SpokenLanguages>.from(json["spoken_languages"].map((x) => SpokenLanguages.fromJson(x))),
        status: json["status"] ?? '',
        tagline: json["tagline"] ?? '',
        title: json["title"] ?? '',
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        voteCount: json["vote_count"] ?? 0,
      );
}

class Genres {
  int id;
  String name;

  Genres({required this.id, required this.name});

  factory Genres.fromJson(Map<String, dynamic> json) =>
      Genres(id: json["id"] ?? 0, name: json["name"] ?? '');
}

class ProductionCompanies {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanies(
      {required this.id,
      required this.logoPath,
      required this.name,
      required this.originCountry});

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      ProductionCompanies(
          id: json["id"] ?? 0,
          logoPath: json["logo_path"] ?? '',
          name: json["name"] ?? '',
          originCountry: json["origin_country"] ?? '');
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({required this.iso31661, required this.name});

  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      ProductionCountries(
          iso31661: json["iso_3166_1"] ?? '', name: json["name"] ?? '');
}

class SpokenLanguages {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguages(
      {required this.englishName, required this.iso6391, required this.name});

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) =>
      SpokenLanguages(
          englishName: json["english_name"] ?? '',
          iso6391: json["iso_639_1"] ?? '',
          name: json["name"] ?? '');
}
