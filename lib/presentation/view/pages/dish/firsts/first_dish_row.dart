import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/presentation/navigation/navigation_routes.dart';

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
        context.go(Uri(
            path: NavigationRoutes.FIRST_DETAIL_PAGE,
            queryParameters: {"id": firstDish.id.toString()}).toString());
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
