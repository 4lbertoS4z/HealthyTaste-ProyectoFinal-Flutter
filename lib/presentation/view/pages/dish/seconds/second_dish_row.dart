import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';

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
        // Acción al tocar
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(secondDish.image, width: 80, height: 80),
          const SizedBox(width: 16),
          Flexible(
            child: Text(secondDish.name),
          ),
        ],
      ),
    );
  }
}
