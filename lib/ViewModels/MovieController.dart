import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/widgets.dart';
import '../Models/MovieDetailModel.dart';
import '../Models/Moviemodel.dart';
import '../Services/Apiservice.dart';
import '../Services/LocalStorageService.dart';

class MovieController extends GetxController {
  var movies = <MovieModel>[].obs;
  var seenMovies = <MovieDetailModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshSeenMovies(); // Safe call
    });
  }

  void refreshSeenMovies() {
    final keys = LocalStorageService.detailCache.keys;
    final movies = keys.map((key) {
      final json = LocalStorageService.getMovieDetail(key);
      if (json != null) {
        return MovieDetailModel.fromJson(json);
      }
      return null;
    }).whereType<MovieDetailModel>().toList();

    seenMovies.assignAll(movies);
  }

  Future<void> search(String query) async {
    isLoading.value = true;

    final trimmedQuery = query.trim(); // Trim leading/trailing spaces

    final cached = LocalStorageService.getCachedMovieList(trimmedQuery);
    if (cached != null) {
      movies.value = cached.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      final result = await ApiService.searchMovies(trimmedQuery);
      movies.value = result;
      LocalStorageService.cacheMovieList(
        trimmedQuery,
        result.map((e) => e.toJson()).toList(),
      );
    }

    isLoading.value = false;
  }


  Future<MovieDetailModel?> getMovieDetails(String imdbID) async {
    final cached = LocalStorageService.getMovieDetail(imdbID);
    if (cached != null) {
      return MovieDetailModel.fromJson(cached);
    }

    final detail = await ApiService.fetchMovieDetail(imdbID);
    if (detail != null) {
      LocalStorageService.cacheMovieDetail(imdbID, detail.toJson());
    }
    return detail;
  }

  Stream<List<MovieDetailModel>> get watchedMoviesStream {
    return LocalStorageService.detailCache.watch().map((_) {
      return _loadInitialWatchedMovies();
    }).startWith(_loadInitialWatchedMovies());
  }

  List<MovieDetailModel> _loadInitialWatchedMovies() {
    final movies = <MovieDetailModel>[];
    for (var value in LocalStorageService.detailCache.values) {
      if (value is Map<String, dynamic>) {
        movies.add(MovieDetailModel.fromJson(value));
      }
    }
    return movies;
  }
}
