import 'package:get/get.dart';
import '../Models/MovieDetailModel.dart';
import '../Services/LocalStorageService.dart';
import 'MovieController.dart';


class MovieDetailController extends GetxController {
  final MovieDetailModel movie;

  MovieDetailController(this.movie);

  @override
  void onInit() {
    super.onInit();
    _cacheMovieDetail();
    _refreshSeenMovies();
  }

  void _cacheMovieDetail() {
    LocalStorageService.cacheMovieDetail(movie.imdbID, movie.toJson());
  }

  void _refreshSeenMovies() {
    Future.delayed(Duration.zero, () {
      if (Get.isRegistered<MovieController>()) {
        Get.find<MovieController>().refreshSeenMovies();
      }
    });
  }
}
