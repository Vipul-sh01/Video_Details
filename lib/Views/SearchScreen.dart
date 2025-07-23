import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constents/AppConstants.dart';
import '../ViewModels/MovieController.dart';
import 'DetailScreen.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.put(MovieController());
  final searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: Text(AppConstants.searchTitle, style: TextStyle(color: AppConstants.textColorWhite)),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 30,
                mainAxisSpacing: 39,
              ),
              itemCount: controller.movies.length,
              itemBuilder: (_, index) {
                final movie = controller.movies[index];
                return GestureDetector(
                  onTap: () async {
                    final detail = await controller.getMovieDetails(movie.imdbID);
                    if (detail != null) {
                      Get.to(() => DetailedScreen(detail));
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            movie.poster,
                            fit: BoxFit.cover,
                            width: double.infinity,
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
                        style: const TextStyle(color: AppConstants.textColorWhite),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
