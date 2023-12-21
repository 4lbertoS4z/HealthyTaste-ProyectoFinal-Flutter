import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/presentation/navigation/navigation_routes.dart';

class SecondDishRow extends StatelessWidget {
  const SecondDishRow({
    super.key,
    required this.secondDish,
  });

  final DishNetworkResponse secondDish;

  @override
  Widget build(BuildContext context) {
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
                borderRadius:
                    BorderRadius.circular(8.0), // Añade esquinas redondeadas
                child: Image.network(
                  secondDish.image,
                  width: 100, // Ancho fijo
                  height: 100, // Altura fija
                  fit: BoxFit
                      .cover, // Esto asegura que la imagen llene el espacio asignado
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  secondDish.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
