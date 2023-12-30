import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_taste/data/dish/local/first_favorites_service.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/presentation/navigation/navigation_routes.dart';

class FirstDishRow extends StatelessWidget {
  const FirstDishRow({
    super.key,
    required this.firstDish,
    required this.favoritesService, // Añade este parámetro
    required this.onFavoriteChanged,
  });

  final DishNetworkResponse firstDish;
  final FirstFavoritesService favoritesService; // Añade esta línea
  final VoidCallback onFavoriteChanged;
  @override
  Widget build(BuildContext context) {
    bool isFavorite =
        favoritesService.isFavorite(firstDish.id); // Verifica si es favorito
    return GestureDetector(
      onTap: () {
        context.go(Uri(
            path: NavigationRoutes.FIRST_DETAIL_PAGE,
            queryParameters: {"id": firstDish.id.toString()}).toString());
      },
      child: Card(
        color: const Color.fromARGB(255, 207, 189, 156),
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(8.0), // Añade esquinas redondeadas
                child: CachedNetworkImage(
                  imageUrl: firstDish.image,
                  width: 100, // Ancho fijo
                  height: 100, // Altura fija
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  firstDish.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                // Añade el botón de favoritos
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.blue : Colors.blue,
                ),
                onPressed: () {
                  favoritesService.toggleFavorite(firstDish.id);
                  favoritesService
                      .saveFavorites(); // Guarda el cambio de estado
                  onFavoriteChanged(); // Llama al callback para actualizar la lista
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
