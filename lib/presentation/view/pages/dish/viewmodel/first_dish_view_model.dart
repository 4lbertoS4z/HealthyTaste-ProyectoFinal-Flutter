import 'dart:async';

import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_repository.dart';
import 'package:healthy_taste/presentation/base/base_view_model.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';

class FirstDishViewModel extends BaseViewModel {
  final DishRepository _firstDishrepository;
  final StreamController<ResourceState<List<DishNetworkResponse>>>
      getFirstDishState = StreamController();
  FirstDishViewModel({required DishRepository firstDishRepository})
      : _firstDishrepository = firstDishRepository;

  fetchtFirstDishes() {
    getFirstDishState.add(ResourceState.loading());
    _firstDishrepository
        .getFirstList()
        .then((value) => getFirstDishState.add(ResourceState.success(value)))
        .catchError((e) => getFirstDishState.add(ResourceState.error(e)));
  }

  @override
  void dispose() {
    getFirstDishState.close();
  }
}
