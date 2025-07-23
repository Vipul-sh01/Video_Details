import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:videoplayer/Constents/AppConstants.dart';
import '../Models/MovieDetailModel.dart';
import '../Widgets/TagChip.dart';


class DetailedScreen extends StatelessWidget {
  final MovieDetailModel movie;

  const DetailedScreen(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Stack(
        children: [
          // Background Poster
          Column(
            children: [
              SizedBox(
                height: 600,
                width: double.infinity,
                child: Image.network(
                  movie.poster,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          Positioned(
            top: 30,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.5),
              child: BackButton(
                color: AppConstants.textColorWhite,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppConstants.transparentColor, AppConstants.backgroundColor ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: 20,
            right: 20,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            color: AppConstants.textColorWhite,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.star_border_outlined, size: 26, color:AppConstants.textColorHint),
                            const SizedBox(width: 4),
                            Text(movie.imdbRating, style: const TextStyle(color: AppConstants.textColorHint)),
                            const SizedBox(width: 16),
                            const Icon(Icons.remove_red_eye, size: 26, color: AppConstants.textColorHint),
                            const SizedBox(width: 4),
                            Text(movie.imdbVotes, style: const TextStyle(color: AppConstants.textColorHint)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text(
                              'Genres',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textColorHint,
                              ),
                            ),
                            const Spacer(),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: movie.genre
                                  .split(', ')
                                  .map((g) => TagChip(g))
                                  .toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: AppConstants.textColorGrey, thickness: 0.2),
                        const SizedBox(height: 8),
                        Text(
                          movie.plot,
                          style: const TextStyle(color: AppConstants.textColorHint54, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Director: ${movie.director}",
                          style: const TextStyle(color: AppConstants.textColorHint54, fontSize: 16),
                        ),
                        Text(
                          "Writer: ${movie.writer}\nActors: ${movie.actors}",
                          style: const TextStyle(color: AppConstants.textColorHint54, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
