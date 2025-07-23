import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static late Box movieCache;
  static late Box detailCache;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    movieCache = await Hive.openBox('movieCache');
    detailCache = await Hive.openBox('detailCache');
  }

  static void cacheMovieList(String key, List<Map<String, dynamic>> value) {
    try {
      movieCache.put(key, value);
    } catch (e) {
      print("Error caching movie list: $e");
    }
  }


  static List<Map<String, dynamic>>? getCachedMovieList(String key) {
    try {
      final data = movieCache.get(key);
      if (data != null && data is List) {
        return List<Map<String, dynamic>>.from(data);
      }
    } catch (e) {
      print("Error reading cached movie list: $e");
    }
    return null;
  }

  static void cacheMovieDetail(String imdbID, Map<String, dynamic> detail) {
    try {
      detailCache.put(imdbID, detail);
    } catch (e) {
      print("Error caching movie detail: $e");
    }
  }

  static Map<String, dynamic>? getMovieDetail(String imdbID) {
    try {
      final data = detailCache.get(imdbID);
      if (data != null && data is Map) {
        return Map<String, dynamic>.from(data);
      }
    } catch (e) {
      print("Error reading cached movie detail: $e");
    }
    return null;
  }
}
