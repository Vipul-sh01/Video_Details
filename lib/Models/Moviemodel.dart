class MovieModel {
  final String title;
  final String year;
  final String imdbID;
  final String poster;

  MovieModel({required this.title, required this.year, required this.imdbID, required this.poster});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['Title'],
      year: json['Year'],
      imdbID: json['imdbID'],
      poster: json['Poster'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Year': year,
      'imdbID': imdbID,
      'Poster': poster,
    };
  }
}
