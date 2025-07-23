import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoplayer/Constents/AppConstants.dart';
import '../Utility/PageTransitions.dart';
import '../ViewModels/MovieController.dart';
import 'DetailScreen.dart';
import 'SearchScreen.dart';

class BrowseScreen extends StatelessWidget {
  final controller = Get.put(MovieController());
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: Text(AppConstants.browseTitle, style: TextStyle(color: AppConstants.textColorWhite)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              style: TextStyle(color: AppConstants.textColorWhite),
              onSubmitted: (value) async {
                await controller.search(value);
                PageTransitions.zoom(SearchScreen());
              },
              decoration: InputDecoration(
                hintText: AppConstants.searchHint,
                hintStyle: TextStyle(color: AppConstants.textColorHint54),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: AppConstants.textColorWhite),
                  onPressed: () async {
                    final query = searchController.text.trim();
                    if (query.isNotEmpty) {
                      await controller.search(query);
                      PageTransitions.zoom(SearchScreen());
                    }
                  },
                ),
              ),
            ),
          ),
         SizedBox(height: 20,),
          Expanded(
            child: Obx(() {
              final seenMovies = controller.seenMovies;
              if (seenMovies.isEmpty) {
                return Center(
                  child: Text(
                    AppConstants.noSeenMovies,
                    style: TextStyle(color: AppConstants.textColorHint54),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 39,
                  ),
                  itemCount: seenMovies.length,
                  itemBuilder: (context, index) {
                    final movie = seenMovies[index];
                    return GestureDetector(
                      onTap: () async {
                        final detail =
                            await controller.getMovieDetails(movie.imdbID);
                        if (detail != null) {
                          await PageTransitions.fadeIn(DetailedScreen(detail));
                          controller.refreshSeenMovies();
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: movie.poster != "N/A"
                                  ? Image.network(
                                      movie.poster,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                  : Container(
                                      color: Colors.grey,
                                      width: double.infinity,
                                      child: const Icon(Icons.movie,
                                          color: AppConstants.textColorWhite),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            movie.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppConstants.textColorHint,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            movie.year,
                            style: const TextStyle(color: AppConstants.textColorGrey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
