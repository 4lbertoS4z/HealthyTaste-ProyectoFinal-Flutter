import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';

class DessertDishRow extends StatelessWidget {
  const DessertDishRow({
    super.key,
    required this.dessertDish,
  });

  final DishNetworkResponse dessertDish;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Acción al tocar
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(dessertDish.image, width: 80, height: 80),
          const SizedBox(width: 16),
          Flexible(
            child: Text(dessertDish.name),
          ),
        ],
      ),
    );
  }
}
