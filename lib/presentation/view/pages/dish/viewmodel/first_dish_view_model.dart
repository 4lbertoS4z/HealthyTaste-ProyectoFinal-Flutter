import 'dart:async';

import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/domain/dish_repository.dart';
import 'package:healthy_taste/presentation/base/base_view_model.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';

class FirstDishViewModel extends BaseViewModel {
  final DishRepository _firstDishRepository;
  final DishLocalRepository _localRepository;

  // Para manejar una lista de platos
  final StreamController<ResourceState<List<DishNetworkResponse>>>
      getFirstDishesState = StreamController();

  // Para manejar un único plato
  final StreamController<ResourceState<DishNetworkResponse>>
      getFirstDishDetailState = StreamController();

  FirstDishViewModel(
      {required DishRepository firstDishRepository,
      required DishLocalRepository localRepository})
      : _firstDishRepository = firstDishRepository,
        _localRepository = localRepository;
// Añade métodos para manejar el estado de favoritos
  void toggleFavorite(int dishId) {
    _localRepository.toggleFavorite(dishId);
    _localRepository
        .saveFirstDishFavorites(); // Guarda los cambios en las preferencias
  }

  bool isFavorite(int dishId) {
    return _localRepository.isFavorite(dishId);
  }

  fetchtFirstDishes() {
    getFirstDishesState.add(ResourceState.loading());
    _firstDishRepository
        .getFirstList()
        .then((value) => getFirstDishesState.add(ResourceState.success(value)))
        .catchError((e) => getFirstDishesState.add(ResourceState.error(e)));
  }

  fetchFirstDish(int id) {
    getFirstDishDetailState.add(ResourceState.loading());
    _firstDishRepository
        .getFirstDishById(id)
        .then((value) =>
            getFirstDishDetailState.add(ResourceState.success(value)))
        .catchError((e) => getFirstDishDetailState.add(ResourceState.error(e)));
  }

  @override
  void dispose() {
    getFirstDishesState.close();
    getFirstDishDetailState.close();
  }
}
