import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/presentation/navigation/navigation_routes.dart';

class SecondDishRow extends StatelessWidget {
  const SecondDishRow({
    super.key,
    required this.secondDish,
    required this.favoritesService,
    required this.onFavoriteChanged,
  });

  final DishNetworkResponse secondDish;
  final DishLocalRepository favoritesService;
  final VoidCallback onFavoriteChanged;
  @override
  Widget build(BuildContext context) {
    bool isFavorite = favoritesService.isFavorite(secondDish.id);
    return GestureDetector(
      onTap: () {
        context.go(Uri(
            path: NavigationRoutes.SECOND_DETAIL_PAGE,
            queryParameters: {"id": secondDish.id.toString()}).toString());
      },
      child: Card(
        color: const Color.fromARGB(255, 207, 189, 156),
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: secondDish.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      secondDish.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.restaurant, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "${secondDish.numPersons}",
                          style: const TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  favoritesService.toggleFavorite(secondDish.id);
                  favoritesService.saveSecondsDishFavorites();
                  onFavoriteChanged();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
