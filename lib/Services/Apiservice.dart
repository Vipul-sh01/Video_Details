import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/MovieDetailModel.dart';
import '../Models/Moviemodel.dart';

class ApiService {
  static const String _baseUrl = 'https://www.omdbapi.com/';
  static const String apiKey = '35882e11';


  static Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    final url = Uri.parse('$_baseUrl?s=$query&page=$page&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Response'] == 'True') {
        return List<MovieModel>.from(data['Search'].map((x) => MovieModel.fromJson(x)));
      }
    }
    return [];
  }

  static Future<MovieDetailModel?> fetchMovieDetail(String imdbID) async {
    final url = Uri.parse('$_baseUrl?i=$imdbID&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Response'] == 'True') {
        return MovieDetailModel.fromJson(data);
      }
    }
    return null;
  }
}
