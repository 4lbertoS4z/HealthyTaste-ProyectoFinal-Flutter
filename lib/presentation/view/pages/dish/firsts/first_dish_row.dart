import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';

class FirstDishRow extends StatelessWidget {
  const FirstDishRow({
    super.key,
    required this.firstDish,
  });

  final DishNetworkResponse firstDish;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Acción al tocar
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(firstDish.image, width: 80, height: 80),
          const SizedBox(width: 16),
          Flexible(
            child: Text(firstDish.name),
          ),
        ],
      ),
    );
  }
}
