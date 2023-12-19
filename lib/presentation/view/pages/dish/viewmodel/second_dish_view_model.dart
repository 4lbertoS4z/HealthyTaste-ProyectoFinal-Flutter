import 'dart:async';

import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_repository.dart';
import 'package:healthy_taste/presentation/base/base_view_model.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';

class SecondDishViewModel extends BaseViewModel {
  final DishRepository _secondDishrepository;
  final StreamController<ResourceState<List<DishNetworkResponse>>>
      getSecondDishState = StreamController();
  SecondDishViewModel({required DishRepository secondDishRepository})
      : _secondDishrepository = secondDishRepository;

  fetchtSecondDishes() {
    getSecondDishState.add(ResourceState.loading());
    _secondDishrepository
        .getSecondsList()
        .then((value) => getSecondDishState.add(ResourceState.success(value)))
        .catchError((e) => getSecondDishState.add(ResourceState.error(e)));
  }

  @override
  void dispose() {
    getSecondDishState.close();
  }
}
