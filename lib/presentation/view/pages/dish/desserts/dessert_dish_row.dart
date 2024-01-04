import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/presentation/navigation/navigation_routes.dart';

class DessertDishRow extends StatelessWidget {
  const DessertDishRow({
    super.key,
    required this.dessertDish,
    required this.favoritesService,
    required this.onFavoriteChanged,
  });

  final DishNetworkResponse dessertDish;
  final DishLocalRepository favoritesService;
  final VoidCallback onFavoriteChanged;
  @override
  Widget build(BuildContext context) {
    bool isFavorite = favoritesService.isFavorite(dessertDish.id);
    return GestureDetector(
      onTap: () {
        context.go(Uri(
            path: NavigationRoutes.DESSERT_DETAIL_PAGE,
            queryParameters: {"id": dessertDish.id.toString()}).toString());
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
                  imageUrl: dessertDish.image,
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
                child: Text(
                  dessertDish.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  favoritesService.toggleFavorite(dessertDish.id);
                  favoritesService.saveDessertsDishFavorites();
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
