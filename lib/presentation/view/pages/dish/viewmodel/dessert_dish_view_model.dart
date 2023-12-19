import 'dart:async';

import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_repository.dart';
import 'package:healthy_taste/presentation/base/base_view_model.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';

class DessertDishViewModel extends BaseViewModel {
  final DishRepository _dessertDishrepository;
  final StreamController<ResourceState<List<DishNetworkResponse>>>
      getDessertDishState = StreamController();
  DessertDishViewModel({required DishRepository dessertDishRepository})
      : _dessertDishrepository = dessertDishRepository;

  fetchtDessertDishes() {
    getDessertDishState.add(ResourceState.loading());
    _dessertDishrepository
        .getDessertsList()
        .then((value) => getDessertDishState.add(ResourceState.success(value)))
        .catchError((e) => getDessertDishState.add(ResourceState.error(e)));
  }

  @override
  void dispose() {
    getDessertDishState.close();
  }
}
